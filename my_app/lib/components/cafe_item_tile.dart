import 'package:flutter/material.dart';
import 'package:my_app/models/cafeitem.dart';

class CafeItemTile extends StatelessWidget {
  final CafeItem item;
  void Function()? onPressed;
  CafeItemTile({
    super.key,
    required this.item,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(left: 25, right: 25, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
      child: Material(
        color: Colors.transparent,
        child: ListTile(
          leading: Image.asset(item.imagePath),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              item.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
          trailing: IconButton(
            icon: Icon(
              Icons.arrow_forward,
              color: Colors.brown[300],
            ),
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}