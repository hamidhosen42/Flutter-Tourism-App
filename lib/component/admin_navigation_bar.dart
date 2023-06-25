import 'package:flutter/material.dart';

import '../main.dart';
import '../screens/admin/admin_bookings.dart';
import '../screens/admin/admin_home.dart';

import '../screens/profile/profile_screen.dart';

class AdminNavigationBars extends StatefulWidget {
  const AdminNavigationBars({super.key});
  static const routeName = '/admin-navigation-screen';

  @override
  State<AdminNavigationBars> createState() => _AdminNavigationBarsState();
}

class _AdminNavigationBarsState extends State<AdminNavigationBars> {
  List<Widget> _pages = [];

  @override
  void initState() {
    _pages = [
      const AdminHome(),
      const AdminBookings(),
      const ProfileScreen(),
    ];
    super.initState();
  }

  int selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: themeManager.themeMode == ThemeMode.light
            ? Colors.transparent
            : Colors.black54,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        currentIndex: selectedPageIndex,
        type: BottomNavigationBarType.shifting,
        onTap: _selectPage,
        items: [
          BottomNavigationBarItem(
            icon: selectedPageIndex == 0
                ? const Icon(Icons.travel_explore)
                : const Icon(Icons.travel_explore_outlined),
            label: 'Tours',
          ),
          BottomNavigationBarItem(
            icon: selectedPageIndex == 1
                ? const Icon(Icons.airplane_ticket)
                : const Icon(Icons.airplane_ticket_outlined),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: selectedPageIndex == 3
                ? const Icon(Icons.person)
                : const Icon(Icons.person_outlined),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
