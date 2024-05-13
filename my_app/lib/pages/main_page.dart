import 'package:flutter/material.dart';
import 'package:my_app/components/category_tile.dart';
import 'package:my_app/pages/cafes_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Map<String, String>> categories = [
    {
      "title": "Parking",
      "imagePath": "lib/images/mq_park.webp",
    },
    {
      "title": "Cafes",
      "imagePath": "lib/images/mq_cafes.webp",
    },
    {
      "title": "Study",
      "imagePath": "lib/images/mq_study.webp",
    },
    {
      "title": "Events & Clubs",
      "imagePath": "lib/images/mq_events.webp",
    },
  ];

  void navigateToCategory(String categoryTitle) {
    //print(categoryTitle);
    switch (categoryTitle) {
      case 'Cafes':
        Navigator.push(
          context,
          MaterialPageRoute(builder:(context) => CafesPage()),
        );
        break;
      // Add other cases for different categories as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Welcome back,',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return CategoryTile(
                  imagePath: categories[index]["imagePath"]!,
                  title: categories[index]["title"]!,
                  onTap: () => navigateToCategory(categories[index]["title"]!),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.grey[300],
  //     body: GridView.builder(
  //       padding: const EdgeInsets.all(25),
  //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //         crossAxisCount: 2,
  //         crossAxisSpacing: 10,
  //         mainAxisSpacing: 10,
  //         childAspectRatio: 1,
  //       ),
  //       itemCount: categories.length,
  //       itemBuilder: (context, index) {
  //         return CategoryTile(
  //           imagePath: categories[index]["imagePath"]!,
  //           title: categories[index]["title"]!,
  //           onTap: () {
  //             print('${categories[index]["title"]} tapped');
  //           },
  //         );
  //       },
  //     ),
  //   );
  // }
}
