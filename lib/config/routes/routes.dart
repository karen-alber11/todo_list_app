import 'package:flutter/material.dart';
import '../../screens/auth/login_screen.dart';
import '../../screens/home/archieved_task_screen.dart';
import '../../screens/home/done_tasks_screen.dart';
import '../../screens/home/profile_screen.dart';
import '../../screens/home/calender_screen.dart';
import '../../screens/home/home_screen.dart';
import 'app_navigation_router.dart';

class Routes {
  static const String login = '/login';
  static const String todoTasks = '/todo-tasks';
  static const String archivedTasks = '/archived-tasks';
  static const String doneTasks = '/done-tasks';
  static const String profile = '/profile';
  static const String calender = '/calender';
  static const String home = '/home';
  static const String appRouter = '/app-router';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case archivedTasks:
        return MaterialPageRoute(
          builder: (_) => ArchievedTasksScreen(),
        );
      case calender:
        return MaterialPageRoute(
          builder: (_) => CalenderScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const AppRouter(),
        );
    }
  }
}
