import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:my_app/const.dart';

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
        color: Theme.of(context).colorScheme.primary,
        //mainAxisAlignment: MainAxisAlignment.center,
        activeColor: myColor,
        //backgroundColor: Theme.of(context).colorScheme.background,
        tabBackgroundColor: Theme.of(context).colorScheme.background,
        tabBorderRadius: 24,
        tabActiveBorder: Border.all(color: myColor),
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