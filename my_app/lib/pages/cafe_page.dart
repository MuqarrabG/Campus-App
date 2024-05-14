import 'package:flutter/material.dart';
import 'package:my_app/components/cafe_item_tile.dart';
import 'package:my_app/models/cafe.dart';
import 'package:my_app/models/cafeitem.dart';
import 'package:provider/provider.dart';

class CafePage extends StatefulWidget {
  final String cafeName;
  const CafePage({super.key, required this.cafeName});

  @override
  State<CafePage> createState() => _CafePageState();
}

class _CafePageState extends State<CafePage> {

  void goToCoffeePage(CafeItem coffee) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => CoffeeOrderPage(
    //       coffee: coffee,
    //     ),
    //   ),
    // );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cafeName, style: const TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Consumer<Cafe>(
        builder: (context, value, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // heading
      
            const SizedBox(height: 25),
      
            // list of coffee
            Expanded(
              child: ListView.builder(
                itemCount: value.cafe.length,
                itemBuilder: (context, index) {
                  // get individual coffee
                  CafeItem eachCoffee = value.cafe[index];
                  // return the tile for this coffee
                  return CafeItemTile(
                    item: eachCoffee,
                    onPressed: () => goToCoffeePage(eachCoffee),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
