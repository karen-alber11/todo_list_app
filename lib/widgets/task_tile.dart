import 'package:flutter/material.dart';
import '../../database/data.dart';
import '../../utils/utils.dart';
import '../../widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
    required this.ref, // Add ref parameter
    this.onCompleted,
    this.onDelete,
  });

  final Task task;
  final WidgetRef ref;  // Declare ref
  final Function(bool?)? onCompleted;
  final VoidCallback? onDelete; // Callback for delete action

  @override
  Widget build(BuildContext context) {
    final style = context.textTheme;
    final colors = context.colorScheme;

    // Adjust styles based on completion status
    final textDecoration = task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none;
    final fontWeight = task.isCompleted ? FontWeight.normal : FontWeight.bold;

    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 10, bottom: 10),
      child: Row(
        children: [
          CircleContainer(
            borderColor: Colors.orange,
            color: task.category.color.withOpacity(0.3), // Default background
            child: Icon(
              task.category.icon,
              color: Colors.orange.withOpacity(0.5), // Default icon color
            ),
          ),
          const SizedBox(width: 20), // Adjusted spacing
          Expanded(
            child: InkWell( // Wrap only the task area, not the delete button
              onTap: () async {
                await showModalBottomSheet(
                  context: context,
                  builder: (ctx) {
                    return TaskDetails(task: task);
                  },
                );
              },
              onLongPress: () async {
                await AppAlerts.showAlertDeleteDialog(
                  context: context,
                  ref: ref, // Pass ref to the alert dialog
                  task: task,
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: style.titleMedium?.copyWith(
                      fontWeight: fontWeight,
                      fontSize: 20,
                      decoration: textDecoration,
                    ),
                  ),
                  Text(
                    task.time,
                    style: style.titleMedium?.copyWith(
                      decoration: textDecoration,
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.black), // Black delete icon
            onPressed: onDelete, // Trigger delete action
          ),
          Checkbox(
            value: task.isCompleted,
            onChanged: onCompleted,
            checkColor: colors.surface, // Color of the checkmark itself
            fillColor: MaterialStateProperty.resolveWith<Color>((states) {
              if (task.isCompleted) {
                return Colors.orange; // Completed state background
              }
              return Colors.amber.shade50; // Default color
            }),
          ),
        ],
      ),
    );
  }
}
