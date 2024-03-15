import 'package:boilerplate/utils/routes/routes.dart';
import 'package:flutter/material.dart';

class MainBottomNavBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainBottomNavBarState();
  }
}

class _MainBottomNavBarState extends State<MainBottomNavBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (value) {
        setState(() {
          _selectedIndex = value;
        });
        var _ = switch (value) {
          1 => Navigator.pushNamed(context, Routes.dashboard),
          _ => null
        };
      },
      currentIndex: _selectedIndex,
      backgroundColor: Colors.white,
      unselectedItemColor: Colors.black,
      unselectedLabelStyle: const TextStyle(color: Colors.black),
      selectedItemColor: Colors.lightBlue,
      selectedLabelStyle: const TextStyle(color: Colors.lightBlue),
      showUnselectedLabels: true,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined), label: 'Projects'),
        BottomNavigationBarItem(
            icon: Icon(Icons.dashboard), label: 'Dashboard'),
        BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Message'),
        BottomNavigationBarItem(
            icon: Icon(Icons.notifications), label: 'Alert'),
      ],
    );
  }
}
