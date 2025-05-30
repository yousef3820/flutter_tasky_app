import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tasky_app/complete_screen.dart';
import 'package:flutter_tasky_app/home_screen.dart';
import 'package:flutter_tasky_app/profile_screen.dart';
import 'package:flutter_tasky_app/todo_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> screens = [
    HomeScreen(),
    TodoScreen(),
    CompleteScreen(),
    Profile(),
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/Home.svg',
              colorFilter: ColorFilter.mode(
                _currentIndex == 0 ? Color(0xFF15B86C) : Color(0xFF9E9E9E),
                BlendMode.srcIn,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/ToDo.svg',
              colorFilter: ColorFilter.mode(
                _currentIndex == 1 ? Color(0xFF15B86C) : Color(0xFF9E9E9E),
                BlendMode.srcIn,
              ),
            ),
            label: 'To Do',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/Completed.svg',
              colorFilter: ColorFilter.mode(
                _currentIndex == 2 ? Color(0xFF15B86C) : Color(0xFF9E9E9E),
                BlendMode.srcIn,
              ),
            ),
            label: 'Completed',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/ProfileIcon.svg',
              colorFilter: ColorFilter.mode(
                _currentIndex == 3 ? Color(0xFF15B86C) : Color(0xFF9E9E9E),
                BlendMode.srcIn,
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),
      body: SafeArea(child: screens[_currentIndex]),
    );
  }
}
