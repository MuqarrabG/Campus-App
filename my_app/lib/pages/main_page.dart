import 'package:flutter/material.dart';
import 'package:my_app/components/category_tile.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        padding: const EdgeInsets.all(25),
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
            onTap: () {
              print('${categories[index]["title"]} tapped');
            },
          );
        },
      ),
    );
  }
}
