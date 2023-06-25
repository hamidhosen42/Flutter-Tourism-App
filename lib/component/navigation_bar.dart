import 'package:flutter/material.dart';
import '../main.dart';

import '../screens/bookings/booking_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/tours/home_screen.dart';

class NavigationBars extends StatefulWidget {
  const NavigationBars({super.key});
  static const routeName = '/navigation-screen';

  @override
  State<NavigationBars> createState() => _NavigationBarsState();
}

class _NavigationBarsState extends State<NavigationBars> {
  List<Widget> _pages = [];

  @override
  void initState() {
    _pages = [
      const HomeScreen(),
      const BookingScreen(),
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
        selectedItemColor: themeManager.themeMode == ThemeMode.light
            ? Colors.deepPurple
            : Colors.deepPurple,
        unselectedItemColor: themeManager.themeMode == ThemeMode.light
            ? Colors.grey
            : Colors.grey,
        showUnselectedLabels: true,
        currentIndex: selectedPageIndex,
        type: BottomNavigationBarType.shifting,
        onTap: _selectPage,
        items: [
          BottomNavigationBarItem(
            icon: selectedPageIndex == 0
                ? const Icon(Icons.home)
                : const Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: selectedPageIndex == 1
                ? const Icon(Icons.airplane_ticket)
                : const Icon(Icons.airplane_ticket_outlined),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: selectedPageIndex == 2
                ? const Icon(Icons.person)
                : const Icon(Icons.person_outlined),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
