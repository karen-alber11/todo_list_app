import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../database/data.dart';
import '../../providers/providers.dart';
import '../../utils/utils.dart';
import '../../widgets/widgets.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/light_theme.dart';
import '../../config/theme/app_text_theme.dart';
import '../../widgets/app_header.dart';
import '../../screens/task_details/add_task_screen.dart';
import '../../database/data.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late Future<List<Task>> _tasksFuture;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() {
    final currentUser = ref.read(currentUserProvider);
    if (currentUser != null) {
      setState(() {
        _tasksFuture = ref.read(userRepositoryProvider).getTasksForUser(currentUser.id);
      });
    }
  }

  Future<void> _refreshTasks() async {
    _loadTasks();
    // Simulate a delay for better UX if needed
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = context.deviceSize;
    final date = ref.watch(dateProvider);
    final currentUser = ref.watch(currentUserProvider);

    if (currentUser == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('No User Logged In')),
        body: const Center(child: Text('Please log in to view tasks')),
      );
    }

    return Scaffold(
      backgroundColor: LightTheme.theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          AppHeader(
            deviceSize: deviceSize,
            date: date,
            ref: ref,
            title: 'My Todo List',
          ),
          Flexible(
            flex: 65,
            child: Stack(
              children: [
                SafeArea(
                  child: RefreshIndicator(
                    onRefresh: _refreshTasks,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(20.0),
                      child: FutureBuilder<List<Task>>(
                        future: _tasksFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return const Center(child: Text('No tasks available.'));
                          } else {
                            final allTasks = snapshot.data!;
                            final inCompletedTasks = _filterTasks(allTasks, false, currentUser.id, date);
                            final completedTasks = _filterTasks(allTasks, true, currentUser.id, date);

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'To-Do Tasks',
                                  style: AppTextTheme.applyBodyColor(
                                      LightTheme.theme.textTheme, bodyColor: Colors.black)
                                      .displayLarge
                                      ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                DisplayListOfTasks(tasks: inCompletedTasks),
                                const SizedBox(height: 20),
                                Text(
                                  'Completed Tasks',
                                  style: AppTextTheme.applyBodyColor(
                                      LightTheme.theme.textTheme, bodyColor: Colors.black)
                                      .displayLarge
                                      ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                DisplayListOfTasks(
                                  isCompletedTasks: true,
                                  tasks: completedTasks,
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: LightTheme.theme.primaryColor,
                                  ),
                                  onPressed: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const CreateTaskScreen(),
                                      ),
                                    );

                                    // Refresh the task list after returning from CreateTaskScreen
                                    _loadTasks();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Add New Task',
                                      style: AppTextTheme.applyBodyColor(
                                          LightTheme.theme.textTheme, bodyColor: Colors.white)
                                          .bodyMedium,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Task> _filterTasks(List<Task> tasks, bool isCompleted, String userId, DateTime selectedDate) {
    final filteredTasks = tasks.where((task) {
      final isUserTask = task.userId == userId;
      final isTaskCompleted = task.isCompleted == isCompleted;
      final isTaskDay = Helpers.isTaskFromSelectedDate(task, selectedDate);
      return isUserTask && isTaskCompleted && isTaskDay;
    }).toList();

    return filteredTasks;
  }
}
