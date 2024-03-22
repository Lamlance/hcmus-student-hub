import 'package:boilerplate/core/stores/routes/routes_store.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:flutter/material.dart';

class MainBottomNavBar extends StatefulWidget {
  const MainBottomNavBar({super.key});
  @override
  State<StatefulWidget> createState() {
    return _MainBottomNavBarState();
  }
}

class _MainBottomNavBarState extends State<MainBottomNavBar> {
  final RoutesStore _routesStore = getIt<RoutesStore>();

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (value) {
        setState(() {
          _routesStore.changeRouteIndex(value);
        });
        var _ = switch (value) {
          1 => {
              if (ModalRoute.of(context)?.settings.name != Routes.dashboard)
                {Navigator.pushReplacementNamed(context, Routes.dashboard)}
            },
          2 => {
              if (ModalRoute.of(context)?.settings.name != Routes.message)
                {Navigator.pushReplacementNamed(context, Routes.message)}
            },
          _ => null
        };
      },
      currentIndex: _routesStore.currentIdx,
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
