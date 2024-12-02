import 'package:flutter/material.dart';
import '../../providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../database/data.dart';
import 'package:go_router/go_router.dart';

@immutable
class AppAlerts {
  const AppAlerts._();

  static displaySnackbar(BuildContext context, String message) {
    final theme = Theme.of(context); // Access the current theme
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: theme.textTheme.bodyMedium, // Use the theme's text style
        ),
        backgroundColor: theme.colorScheme.onSecondary, // Use the theme's color scheme
      ),
    );
  }

  static Future<void> showAlertDeleteDialog({
    required BuildContext context,
    required WidgetRef ref,
    required Task task,
  }) async {
    final theme = Theme.of(context); // Access the current theme

    Widget cancelButton = TextButton(
      child: const Text('NO'),
      onPressed: () => context.pop(),
    );
    Widget deleteButton = TextButton(
      onPressed: () async {
        // Perform the task deletion
        await ref.read(tasksProvider.notifier).deleteTask(task).then(
              (value) {
            // Display a success snackbar after deletion
            displaySnackbar(
              context,
              'Task deleted successfully',
            );
            // Close the dialog
            context.pop();
          },
        );
      },
      child: const Text('YES'),
    );

    AlertDialog alert = AlertDialog(
      title: const Text('Are you sure you want to delete this task?'),
      actions: [
        deleteButton,
        cancelButton,
      ],
    );

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
