import 'package:flutter/material.dart';
import 'package:task_manager/presentation/screens/cancelled_task_screen.dart';
import 'package:task_manager/presentation/screens/complete_task_screen.dart';
import 'package:task_manager/presentation/screens/new_task_screen.dart';
import 'package:task_manager/presentation/screens/progress_task_screen.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  int _currentSelectedIndex = 0;

  final List<Widget> _screen = [
    const NewTaskScreen(),
    const CompleteTaskScreen(),
    const CancelledTaskScreen(),
    const ProgressTaskScreen(),
  ];

  final List<Color> _selectedColors = [
    const Color(0xff5cafc5),
    const Color(0xff68c07c),
    const Color(0xffd06161),
    const Color(0xffb2a963),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screen[_currentSelectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentSelectedIndex,
        selectedItemColor: _selectedColors[_currentSelectedIndex],
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: (index) {
          _currentSelectedIndex = index;
          if (mounted) {
            setState(() {});
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.add_task_rounded), label: 'New Task'),
          BottomNavigationBarItem(
              icon: Icon(Icons.done_all), label: 'Complete'),
          BottomNavigationBarItem(
              icon: Icon(Icons.cancel_outlined), label: 'Cancelled'),
          BottomNavigationBarItem(
              icon: Icon(Icons.donut_large_rounded), label: 'Progress'),
        ],
      ),
    );
  }
}
