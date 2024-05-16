import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:my_app/models/order.dart';
import 'package:my_app/models/cart_item.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  Future<List<List<CartItem>>>? _ordersFuture;

  @override
  void initState() {
    super.initState();
    _ordersFuture = Order.getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text('Orders'),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: FutureBuilder<List<List<CartItem>>>(
        future: _ordersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading orders'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Wow so empty'));
          } else {
            final orders = snapshot.data!;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return OrderTile(order: order);
              },
            );
          }
        },
      ),
    );
  }
}

class OrderTile extends StatelessWidget {
  final List<CartItem> order;

  const OrderTile({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalPrice = order.fold(0, (sum, item) => sum + item.item.price * item.quantity);

    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ExpansionTile(
        title: Text('Order Total: \$${totalPrice.toStringAsFixed(2)}'),
        children: order.map((cartItem) {
          return ListTile(
            title: Text(
              cartItem.item.isCoffee
              ? StringUtils.capitalize('${cartItem.item.type.name}')
              : cartItem.item.name
              ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Quantity: ${cartItem.quantity}'),
                if (cartItem.item.isCoffee) ...[
                  Text(StringUtils.capitalize('${cartItem.item.size.name}')),
              Text(StringUtils.capitalize('${cartItem.item.milk.name}')),
              if (cartItem.item.extraShot) ...[Text('Extra Shot')],
                ],
                Text('Price: \$${(cartItem.item.price * cartItem.quantity).toStringAsFixed(2)}'),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
