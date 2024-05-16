/*
  Code in this file comes from "https://github.com/mitchkoko/ModernLoginUI"
  - Changes to code include transforming to match my UI design from Deliverable 1
*/

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:my_app/components/bottom_nav_bar.dart';
import 'package:my_app/const.dart';
import 'package:my_app/pages/main_page.dart';
import 'package:my_app/pages/map_page.dart';
import 'package:my_app/pages/order_page.dart';
import 'package:my_app/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  // navigate bottom bar
  int _selectedIndex = 0;
  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //pages
  final List<Widget> _pages = [
    MainPage(),
    MapPage(),
    OrderPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        bottomNavigationBar: MyBottomNavBar(
          OnTabChange: (index) => navigateBottomBar(index),
        ),
        appBar: AppBar(
          iconTheme: IconThemeData(color: myColor),
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Row(
            children: [
              Icon(
                Icons.account_circle,
                color: HexColor("#F70E00"),
                size: 30,
              ),
              const SizedBox(width: 10,),
              Text(user.email!, style: TextStyle(color: Colors.black),)
            ],
          ),
          // actions: [
          //   IconButton(
          //     onPressed: signUserOut,
          //     icon: Icon(Icons.logout),
          //   )
          // ],
        ),
        endDrawer: Drawer(
          backgroundColor: Theme.of(context).colorScheme.background,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Theme.of(context).colorScheme.background),
                accountName: Text(user.email!, style: TextStyle(color: HexColor("#F70E00")),),
                accountEmail: Text(user.email!),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: HexColor("#F70E00"),
                  child: Text(
                    user.email![0].toUpperCase(),
                    style: const TextStyle(fontSize: 40.0),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Provider.of<ThemeProvider>(context).themeData.brightness == Brightness.light
                  ? Icons.light_mode
                  : Icons.dark_mode, 
                  ),
                title: const Text('Theme'),
                onTap: () {
                  Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('About'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.logout_rounded, color: HexColor("#F70E00"), size: 30,),
                title: Text('LOG OUT', style: TextStyle(color: HexColor("#F70E00"), fontWeight: FontWeight.bold),),
                onTap: signUserOut,
              ),
            ],
          ),
        ),
        body: _pages[_selectedIndex],
      ),
    );
  }
}
