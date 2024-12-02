import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/home/archieved_task_screen.dart';
import '../../screens/home/calender_screen.dart';

class AppRouter extends StatefulWidget {
  const AppRouter({Key? key}) : super(key: key);

  @override
  _AppRouterState createState() => _AppRouterState();
}

class _AppRouterState extends State<AppRouter> {
  int _currentIndex = 1;
  final PageController _pageController = PageController(initialPage: 1);

  final List<Widget> _pages = [
    ArchievedTasksScreen(),
    HomeScreen(),
    CalenderScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        physics: const NeverScrollableScrollPhysics(), // Disable swipe navigation
        children: _pages,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        animationDuration: const Duration(milliseconds: 300),
        color: Colors.orange,
        backgroundColor: Colors.amber.shade50,
        height: 60, // Adjust the height as needed
        items: [
          Icon(Icons.archive, size: 30, color: _currentIndex == 0 ? Colors.white : Colors.white),
          Icon(Icons.list, size: 30, color: _currentIndex == 1 ? Colors.white : Colors.white),
          Icon(Icons.calendar_today, size: 30, color: _currentIndex == 2 ? Colors.white : Colors.white),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}
