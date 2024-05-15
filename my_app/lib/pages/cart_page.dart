import 'package:flutter/material.dart';
import 'package:my_app/components/cart_tile.dart';
import 'package:my_app/components/my_button.dart';
import 'package:my_app/models/cafe.dart';
import 'package:my_app/models/cart_item.dart';
import 'package:my_app/models/order.dart';
import 'package:my_app/pages/home_page.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  void removeItemFromCart(CartItem item) {
    Provider.of<Cafe>(context, listen: false).removeItemFromCart(item);
  }

  // order button
  // void order() async {
  //   await Order.saveOrder(Provider.of<Cafe>(context, listen: false).userCart);
  //   Provider.of<Cafe>(context, listen: false).clearCart();
    
  //   Navigator.popUntil(context, ModalRoute.withName('/'));

  //   showDialog(
  //     context: context,
  //     builder: (context) => const AlertDialog(
  //       backgroundColor: Colors.brown,
  //       title: Text(
  //         "Order Successful",
  //         style: TextStyle(color: Colors.white),
  //       ),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
     final cafe = Provider.of<Cafe>(context);

    // Order button
    void order() async {
      await Order.saveOrder(cafe.userCart);
      cafe.clearCart();  // Clear the cart after saving the order

      Navigator.popUntil(context, ModalRoute.withName('/'));

      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          backgroundColor: Colors.brown,
          title: Text(
            "Order Successful",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart", style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Consumer<Cafe>(
      builder: (context, value, child) => Column(
        children: [
          // heading
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 25.0, top: 25, bottom: 25),
                child: Text(
                  'Cart Total: \$${value.cartTotal().toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          ),
    
          // list of cart items
          Expanded(
            child: ListView.builder(
              itemCount: value.userCart.length,
              itemBuilder: (context, index) {
                // get individual cart items
                CartItem item = value.userCart[index];
    
                // return as a list tile
                return CartTile(
                  item: item,
                  onPressed: () => removeItemFromCart(item),
                );
              },
            ),
          ),
    
          // pay button
          MyButton(text: "Order", onTap: order),

          const SizedBox(height: 20)
        ],
      ),
    ),
    );
  }
}