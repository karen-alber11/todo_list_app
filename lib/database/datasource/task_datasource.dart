import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../database/data.dart';
import '../../utils/app_keys.dart';
import '../../utils/task_keys.dart';
import '../../utils/user_keys.dart';

class TaskDatasource {
  static final TaskDatasource _instance = TaskDatasource._();

  factory TaskDatasource() => _instance;

  TaskDatasource._() {
    _initDb();
  }

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'tasks.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  void _onCreate(Database db, int version) async {
    // Create the tasks table with a foreign key to users
    await db.execute(''' 
      CREATE TABLE ${AppKeys.tasksTable} (
        ${TaskKeys.id} TEXT PRIMARY KEY AUTOINCREMENT,
        ${TaskKeys.title} TEXT NOT NULL,
        ${TaskKeys.note} TEXT,
        ${TaskKeys.date} TEXT,
        ${TaskKeys.time} TEXT,
        ${TaskKeys.category} TEXT,
        ${TaskKeys.isCompleted} INTEGER NOT NULL DEFAULT 0,
        ${TaskKeys.userId} TEXT NOT NULL,
        FOREIGN KEY(${TaskKeys.userId}) REFERENCES ${AppKeys.usersTable}(${UserKeys.id}) ON DELETE CASCADE
      )
    ''');
  }

  // Add a Task to the database
  Future<int> addTask(Task task) async {
    final db = await database;
    return db.transaction((txn) async {
      return await txn.insert(
        AppKeys.tasksTable,
        task.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  // Get tasks by User ID (accepts int)
  Future<List<Task>> getTasksForUser(String userId) async {
    final db = await database;

    // Ensure userId is passed as a String, no casting needed if it's already a String.
    final List<Map<String, dynamic>> maps = await db.query(
      AppKeys.tasksTable,
      where: '${TaskKeys.userId} = ?',
      whereArgs: [userId],  // Make sure userId is always a String
    );

    return maps.map((taskMap) => Task.fromJson(taskMap)).toList();
  }



  // Get all tasks (if needed)
  Future<List<Task>> getAllTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(AppKeys.tasksTable);
    return maps.map((taskMap) => Task.fromJson(taskMap)).toList();
  }

  // Update a Task in the database
  Future<int> updateTask(Task task) async {
    final db = await database;
    return db.update(
      AppKeys.tasksTable,
      task.toJson(),
      where: '${TaskKeys.id} = ?',
      whereArgs: [task.id],
    );
  }

  // Delete a Task from the database
  Future<int> deleteTask(Task task) async {
    final db = await database;
    return db.delete(
      AppKeys.tasksTable,
      where: '${TaskKeys.id} = ?',
      whereArgs: [task.id],
    );
  }
}
