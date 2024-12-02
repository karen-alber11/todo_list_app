import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../database/data.dart';
import '../../providers/providers.dart';
import 'package:intl/intl.dart';

@immutable
class Helpers {
  const Helpers._();

  // Convert TimeOfDay to a string (12-hour format)
  static String timeToString(TimeOfDay time) {
    try {
      final DateTime now = DateTime.now();
      final date = DateTime(
        now.year,
        now.month,
        now.day,
        time.hour,
        time.minute,
      );
      final formatType = DateFormat.jm();
      return formatType.format(date);
    } catch (e) {
      return '12:00';
    }
  }

  // Date picker method to select a date and update the provider
  static void selectDate(BuildContext context, WidgetRef ref) async {
    final initialDate = ref.read(dateProvider);
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2060),
    );

    if (pickedDate != null) {
      ref.read(dateProvider.notifier).state = pickedDate;
    }
  }

  // Compare if the task's date matches the selected date
  static bool isTaskFromSelectedDate(Task task, DateTime selectedDate) {
    // Convert the task date (assuming it's in String format) to a DateTime object
    final DateTime taskDate = _stringToDateTime(task.date);

    // Check if the task's year, month, and day match the selected date
    return taskDate.year == selectedDate.year &&
        taskDate.month == selectedDate.month &&
        taskDate.day == selectedDate.day;
  }

  // Helper method to convert task's date from String to DateTime
  static DateTime _stringToDateTime(String dateString) {
    try {
      // Assuming the task date format is "MMM dd, yyyy" (e.g., Jan 1, 2024)
      DateFormat format = DateFormat.yMMMd(); // "MMM dd, yyyy"
      return format.parse(dateString);
    } catch (e) {
      return DateTime.now(); // Return the current date if the parsing fails
    }
  }

  // Method to format DateTime to String (e.g., "Jan 1, 2024")
  static String dateFormatter(DateTime date) {
    try {
      return DateFormat.yMMMd().format(date); // "MMM dd, yyyy"
    } catch (e) {
      return DateFormat.yMMMd().format(DateTime.now()); // Default to current date if error occurs
    }
  }
}
