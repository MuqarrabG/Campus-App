import 'package:flutter/material.dart';
import 'package:my_app/components/cafe_item_tile.dart';
import 'package:my_app/const.dart';
import 'package:my_app/models/cafe.dart';
import 'package:my_app/models/cafe_item.dart';
import 'package:my_app/pages/cafe_order_page.dart';
import 'package:my_app/pages/cart_page.dart';
import 'package:provider/provider.dart';

class CafePage extends StatefulWidget {
  final String cafeName;
  const CafePage({super.key, required this.cafeName});

  @override
  State<CafePage> createState() => _CafePageState();
}

class _CafePageState extends State<CafePage> {

  void goToCoffeePage(CafeItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CafeOrderPage(
          item: item,
          cafeName: widget.cafeName
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cafeName, style: const TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        iconTheme: IconThemeData(color: myColor),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const CartPage();
        })),
        child: Icon(
          Icons.shopping_cart,
          color: myColor,
        ),
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
                  CafeItem item = value.cafe[index];
                  // return the tile for this coffee
                  return CafeItemTile(
                    item: item,
                    onPressed: () => goToCoffeePage(item),
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
