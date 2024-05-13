import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyBottomNavBar extends StatelessWidget {
  void Function(int)? OnTabChange;
  MyBottomNavBar({super.key, required this.OnTabChange,});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      child: GNav(
        gap: 8,
        onTabChange: (value) => OnTabChange!(value),
        color: Colors.grey[400],
        //mainAxisAlignment: MainAxisAlignment.center,
        activeColor: Colors.grey[700],
        tabBackgroundColor: Colors.grey.shade300,
        tabBorderRadius: 24,
        tabActiveBorder: Border.all(color: Colors.white),
        tabs: const [
          GButton(
            icon: Icons.home, 
            text: 'Home',
            ),
          GButton(
            icon: Icons.map, 
            text: "Map",
            ),
          GButton(
            icon: Icons.book,
            text: "Orders",
          ),  
        ],
        ),
    );
  }
}