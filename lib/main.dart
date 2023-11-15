import 'package:city_pulse/favorite_events_screen/favorite_events_screen.dart';
import 'package:city_pulse/popular_events_screen/popular_events_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'event/event_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => EventProvider(),
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    const PopularEventsScreenView(),
    const FavoriteEventsScreenView()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBarWidget(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}


class BottomNavigationBarWidget extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavigationBarWidget({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Image.asset(
              'assets/images/home_empty.png',
              width: 30.0,
              height: 30.0,
            ),
          ),
          label: 'Home',
          activeIcon: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Image.asset(
              'assets/images/home_full.png',
              width: 30.0,
              height: 30.0,
            ),
          ),
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Image.asset(
              'assets/images/heart_empty.png',
              width: 30.0,
              height: 30.0,
            ),
          ),
          label: 'Favorites',
          activeIcon: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Image.asset(
              'assets/images/heart_full_purple.png',
              width: 30.0,
              height: 30.0,
            ),
          ),
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Image.asset(
              'assets/images/user_empty.png',
              width: 30.0,
              height: 30.0,
            ),
          ),
          label: 'Profile',
        )
      ],
      currentIndex: selectedIndex,
      selectedItemColor: const Color(0xff515BE9),
      onTap: onItemTapped,
    );
  }
}