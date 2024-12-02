import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../database/data.dart';
import '../../providers/providers.dart';
import '../../utils/utils.dart';
import '../../widgets/widgets.dart';
import 'package:intl/intl.dart';

class CreateTaskScreen extends ConsumerStatefulWidget {
  static CreateTaskScreen builder(BuildContext context) => const CreateTaskScreen();
  const CreateTaskScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends ConsumerState<CreateTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const DisplayWhiteText(
          text: 'Add New Task',
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CommonTextField(
                hintText: 'Task Title',
                title: 'Task Title',
                controller: _titleController,
              ),
              const SizedBox(height: 30),
              const CategoriesSelection(),
              const SizedBox(height: 30),
              const SelectDateTime(),
              const SizedBox(height: 30),
              CommonTextField(
                hintText: 'Notes',
                title: 'Notes',
                maxLines: 6,
                controller: _noteController,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
                onPressed: _createTask,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: DisplayWhiteText(
                    text: 'Save',
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  void _createTask() async {
    final title = _titleController.text.trim();
    final note = _noteController.text.trim();
    final time = ref.watch(timeProvider);
    final date = ref.watch(dateProvider);
    final category = ref.watch(categoryProvider);

    final user = ref.watch(currentUserProvider); // Fetch the current user
    final userId = user?.id ?? '';

    if (userId.isEmpty) {
      AppAlerts.displaySnackbar(context, 'User not logged in');
      return;
    }

    if (title.isNotEmpty) {
      try {
        final task = Task(
          title: title,
          category: category,
          time: Helpers.timeToString(time),
          date: DateFormat.yMMMd().format(date),
          note: note,
          isCompleted: false,
          userId: userId,
        );

        await ref.read(tasksProvider.notifier).createTask(userId, task).then((value) {
          AppAlerts.displaySnackbar(context, 'Task created successfully');

          // After task creation, print tasks for the user
          _printTasksForUser(userId);

          Navigator.pop(context);
        }).catchError((e) {
          AppAlerts.displaySnackbar(context, 'Failed to create task: $e');
        });
      } catch (e) {
        AppAlerts.displaySnackbar(context, 'Error creating task: $e');
      }
    } else {
      AppAlerts.displaySnackbar(context, 'Title cannot be empty');
    }
  }


  // Print all tasks for the current user
  void _printTasksForUser(String userId) async {
    final tasks = await ref.read(tasksProvider.notifier).getTasksByUserId(userId);
    print('Tasks for User ID $userId:');
    for (var task in tasks) {
      print('Task Title: ${task.title}, Category: ${task.category}, Time: ${task.time}');
    }
  }
}
