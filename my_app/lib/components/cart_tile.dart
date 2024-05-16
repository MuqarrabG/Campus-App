import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_app/models/cart_item.dart';

class CartTile extends StatelessWidget {
  final CartItem item;
  final void Function()? onPressed;

  CartTile({
    super.key,
    required this.item,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(25),
      ),
      margin: const EdgeInsets.only(left: 25, right: 25, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: ListTile(
        leading: Image.asset(item.item.imagePath),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            item.item.isCoffee 
            ? StringUtils.capitalize('${item.item.type.name}')
            : item.item.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Quantity: ${item.quantity}'),
            if (item.item.isCoffee) ...[
              const SizedBox(height: 5),
              Text(StringUtils.capitalize('${item.item.size.name}')),
              Text(StringUtils.capitalize('${item.item.milk.name}')),
              if (item.item.extraShot) ...[Text('Extra Shot')],
            ],
            const SizedBox(height: 5),
            Text('Total: \$${(item.item.price * item.quantity).toStringAsFixed(2)}'),
          ],
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.brown[300],
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
