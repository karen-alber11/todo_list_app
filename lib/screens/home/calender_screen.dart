import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../database/data.dart';
import '../../providers/providers.dart';
import '../../utils/utils.dart';
import '../../widgets/widgets.dart';
import '../../config/theme/app_text_theme.dart';
import '../../config/theme/dark_theme.dart';
import '../../widgets/display_list_of_tasks.dart';
import '../../widgets/app_header.dart';

class CalenderScreen extends ConsumerStatefulWidget {
  const CalenderScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends ConsumerState<CalenderScreen> {
  late DateTime _selectedDate; // Tracks the selected date on the calendar

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now(); // Initialize with today's date
  }

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(tasksProvider).tasks; // Fetch tasks from provider
    final filteredTasks = _filterTasksByDate(tasks, _selectedDate);

    // Get device size
    final deviceSize = MediaQuery.of(context).size;
    final date = Helpers.dateFormatter(_selectedDate); // Format the date for display

    return Scaffold(
      body: Column(
        children: [
          // Pass the correct formatted date and other data to AppHeader
          AppHeader(
            deviceSize: deviceSize,
            date: _selectedDate, // Pass the formatted date string here
            ref: ref,
            title: 'Calender', // Dynamic header title
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
                      children: [
                        _buildCalendar(),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Tasks on $date', // Use the formatted date for display
                            style: AppTextTheme.applyBodyColor(
                              DarkTheme.theme.textTheme,
                              bodyColor: Colors.black,
                            ).displayLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        filteredTasks.isNotEmpty
                            ? DisplayListOfTasks(tasks: filteredTasks)
                            : const Center(
                          child: DisplayListOfTasks(
                            tasks: [], // Empty task list when no tasks are found for the selected date
                          ),
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

  /// Builds the calendar widget
  Widget _buildCalendar() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TableCalendar(
        focusedDay: _selectedDate,
        firstDay: DateTime(2000),
        lastDay: DateTime(2100),
        calendarFormat: CalendarFormat.month,
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDate = selectedDay; // Update the selected date
          });
        },
        selectedDayPredicate: (day) => isSameDay(day, _selectedDate),
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: DarkTheme.theme.primaryColor,
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: Colors.orange,
            shape: BoxShape.circle,
          ),
          defaultDecoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          weekendDecoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  /// Filters tasks based on the selected date
  List<Task> _filterTasksByDate(List<Task> tasks, DateTime selectedDate) {
    print('Filtering tasks for date: ${Helpers.dateFormatter(selectedDate)}');
    return tasks.where((task) {
      print('Task date: ${task.date}'); // Log task's raw date string
      final isTaskOnSelectedDate = Helpers.isTaskFromSelectedDate(task, selectedDate);
      print('Is task on selected date: $isTaskOnSelectedDate');
      return isTaskOnSelectedDate;
    }).toList();
  }
}
