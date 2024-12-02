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

class ArchievedTasksScreen extends ConsumerWidget {
  const ArchievedTasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceSize = context.deviceSize;
    final date = ref.watch(dateProvider);
    final taskState = ref.watch(tasksProvider);
    final archivedTasks = _archivedTasks(taskState.tasks, ref);

    return Scaffold(
      backgroundColor: LightTheme.theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          AppHeader(
            deviceSize: deviceSize,
            date: date,
            ref: ref,
            title: 'Archived Tasks', // Dynamic header title
          ),
          Flexible(
            flex: 65,
            child: Stack(
              children: [
                SafeArea(
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Archived Tasks',
                          style: AppTextTheme.applyBodyColor(
                              LightTheme.theme.textTheme, bodyColor: Colors.black)
                              .displayLarge
                              ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        DisplayListOfTasks(
                          tasks: archivedTasks,
                        ),
                      ],
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

  List<Task> _archivedTasks(List<Task> tasks, WidgetRef ref) {
    final date = ref.watch(dateProvider);
    final List<Task> archivedTask = [];

    for (var task in tasks) {
      if (task.isCompleted) {
        final isTaskDay = Helpers.isTaskFromSelectedDate(task, date);
        if (isTaskDay) {
          archivedTask.add(task);
        }
      }
    }
    return archivedTask;
  }
}
