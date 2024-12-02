import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';
import '../../database/data.dart';
import '../../utils/app_keys.dart';
import '../../utils/user_keys.dart';
import '../../database/models/user.dart';

class UserDatasource {
  static final UserDatasource _instance = UserDatasource._();

  factory UserDatasource() => _instance;

  UserDatasource._();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'users.db');

    return await openDatabase(
      path,
      version: 2, // Ensure the version is 2 for migration
      onCreate: _onCreate,
      onUpgrade: _onUpgrade, // Add onUpgrade for migrations
    );
  }

  void _onCreate(Database db, int version) async {
    await db.execute(''' 
      CREATE TABLE ${AppKeys.usersTable} (
        ${UserKeys.id} TEXT PRIMARY KEY,
        ${UserKeys.name} TEXT NOT NULL,
        ${UserKeys.email} TEXT NOT NULL UNIQUE,
        ${UserKeys.password} TEXT NOT NULL
      )
    ''');

    await db.execute(''' 
      CREATE TABLE tasks (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        userId TEXT NOT NULL
      )
    ''');
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        CREATE TABLE tasks_new (
          id TEXT PRIMARY KEY,
          title TEXT NOT NULL,
          userId TEXT NOT NULL
        )
      ''');
      await db.execute('''
        INSERT INTO tasks_new (id, title)
        SELECT id, title FROM tasks
      ''');
      await db.execute('DROP TABLE tasks');
      await db.execute('ALTER TABLE tasks_new RENAME TO tasks');
    }
  }

  Future<void> resetDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'users.db');
    await deleteDatabase(path);
    print('Database reset');
  }

  Future<bool> createUser(User user) async {
    try {
      final db = await database;

      final userId = Uuid().v4();
      final newUser = user.copyWith(id: userId);

      final int result = await db.insert(
        AppKeys.usersTable,
        newUser.toJson(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );

      if (result == 0) {
        print('Insert failed: Duplicate email');
        return false;
      }

      await _printDatabase();
      return true;
    } catch (e) {
      print('Database error: $e');
      return false;
    }
  }

  Future<List<User>> getAllUsers() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(AppKeys.usersTable);
    return maps.map((userMap) => User.fromJson(userMap)).toList();
  }

  Future<User?> getUserByName(String name) async {
    final db = await database;

    final maps = await db.query(
      AppKeys.usersTable,
      where: '${UserKeys.name} = ?',
      whereArgs: [name],
    );

    return maps.isNotEmpty ? User.fromJson(maps.first) : null;
  }

  Future<User?> getUserByEmail(String email) async {
    final db = await database;

    final maps = await db.query(
      AppKeys.usersTable,
      where: '${UserKeys.email} = ?',
      whereArgs: [email],
    );

    return maps.isNotEmpty ? User.fromJson(maps.first) : null;
  }

  Future<bool> updateUser(User user) async {
    try {
      final db = await database;

      final rowsAffected = await db.update(
        AppKeys.usersTable,
        user.toJson(),
        where: '${UserKeys.id} = ?',
        whereArgs: [user.id],
      );

      return rowsAffected > 0;
    } catch (e) {
      print('Error updating user: $e');
      return false;
    }
  }

  Future<bool> deleteUser(String userId) async {
    try {
      final db = await database;

      final rowsDeleted = await db.delete(
        AppKeys.usersTable,
        where: '${UserKeys.id} = ?',
        whereArgs: [userId],
      );

      return rowsDeleted > 0;
    } catch (e) {
      print('Error deleting user: $e');
      return false;
    }
  }

  Future<void> _printDatabase() async {
    final db = await database;
    final users = await getAllUsers();
    print('Database contents:');
    for (var user in users) {
      print('User ID: ${user.id}, Name: ${user.name}, Email: ${user.email}');
    }
  }
}
