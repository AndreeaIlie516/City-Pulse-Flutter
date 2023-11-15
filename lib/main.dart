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

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: PopularEventsScreenView(),
        bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }
}


class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Image.asset(
              'assets/images/home_empty.png',
              width: 30.0,
              height: 30.0,
            ),
          ),
          label: 'Home',
          activeIcon: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Image.asset(
              'assets/images/home_full.png',
              width: 30.0,
              height: 30.0,
            ),
          ),
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Image.asset(
              'assets/images/heart_empty.png',
              width: 30.0,
              height: 30.0,
            ),
          ),
          label: 'Favorites',
          activeIcon: Padding(
            padding: EdgeInsets.only(top: 5),
            child: Image.asset(
              'assets/images/heart_full_purple.png',
              width: 30.0,
              height: 30.0,
            ),
          ),
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(top: 5),
            child: Image.asset(
              'assets/images/user_empty.png',
              width: 30.0,
              height: 30.0,
            ),
          ),
          label: 'Profile',
        )
      ],
      selectedItemColor: const Color(0xff515BE9),
    );
  }
}