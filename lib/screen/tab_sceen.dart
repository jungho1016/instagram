// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:insta/screen/account_sceen.dart';
import 'package:insta/screen/home_sceen.dart';
import 'package:insta/screen/search_sceen.dart';

class TabSceen extends StatefulWidget {
  const TabSceen({Key? key}) : super(key: key);

  @override
  State<TabSceen> createState() => _TabSceenState();
}

class _TabSceenState extends State<TabSceen> {
  int _currentIndex = 0;

  final _pages = [
    HomeScreen(),
    SearchSceen(),
    AccountSceen(),
    ProfileScreen(providerConfigs: [
      EmailProviderConfiguration(),
    ], avatarSize: 24),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Account'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box_outlined), label: 'Profile'),
        ],
      ),
    );
  }
}
