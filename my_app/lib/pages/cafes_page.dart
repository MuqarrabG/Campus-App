import 'package:flutter/material.dart';
import 'package:my_app/models/cafe.dart';
import 'package:my_app/pages/cafe_page.dart';

class CafesPage extends StatefulWidget {
  CafesPage({super.key});

  @override
  State<CafesPage> createState() => _CafesPageState();
}

class _CafesPageState extends State<CafesPage> {
  final List<Cafe> cafes = [
    Cafe("Esc Cafe", true),
    Cafe("Crunch Cafe", false),
    Cafe("Cult Eatery", false),
    Cafe("Library Cafe", false),
    Cafe("Piccolo Me", false),
    Cafe("St Laurent Cafe", false),
    Cafe("Taste Baguette", false),
  ];

  void navigateToCafe(String cafeName, BuildContext context) {
    //print(categoryTitle);
    switch (cafeName) {
      case 'Esc Cafe':
        Navigator.push(
          context,
          MaterialPageRoute(builder:(context) => CafePage(cafeName: cafeName,)),
        );
        break;
      // Add other cases for different categories as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cafes', style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: cafes.length,
        itemBuilder: (context, index) {
          final cafe = cafes[index];
          return ListTile(
            leading: const Icon(Icons.coffee, size: 30, color: Colors.black,),  // Custom icon for each cafe
            title: Text(cafe.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  cafe.isOpen 
                  ? 'lib/images/icons8-open-sign-50.png' 
                  : 'lib/images/icons8-close-sign-50.png',
                  width: 40,
                ),
                const SizedBox(width: 70,),
                const Icon(Icons.arrow_forward_ios, size: 30),
              ],
            ),
            onTap: () => navigateToCafe(cafe.name, context),
          );
        },
      ),
    );
  }
}
