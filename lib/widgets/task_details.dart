import 'package:flutter/material.dart';
import '../../database/data.dart';
import '../../utils/utils.dart';
import '../../widgets/circle_container.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    final style = context.textTheme;

    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleContainer(
            color: task.category.color.withOpacity(0.3),
            child: Icon(
              task.category.icon,
              color: task.category.color,
            ),
          ),
          SizedBox(height: 20),
          Text(
            task.title,
            style: style.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(task.time, style: style.titleMedium),
          SizedBox(height: 20),
          Visibility(
            visible: !task.isCompleted,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Task to be completed on '),
                Text(task.date),
                Icon(
                  Icons.check_box,
                  color: task.category.color,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Divider(
            color: task.category.color,
            thickness: 1.5,
          ),
          SizedBox(height: 20),
          Text(
            task.note.isEmpty
                ? 'There is no additional note for this task'
                : task.note,
            style: context.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Visibility(
            visible: task.isCompleted,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Task Completed'),
                Icon(
                  Icons.check_box,
                  color: Colors.green,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
