import 'cafe_item.dart';

class CartItem {
  final CafeItem item;
  int quantity;

  CartItem({
    required this.item,
    this.quantity = 1,
  });

  // Convert a CartItem into a Map. The keys must correspond to the names of the
  // fields in the JSON object.
  Map<String, dynamic> toJson() => {
        'item': item.toJson(),
        'quantity': quantity,
      };

  // Convert a Map into a CartItem. The keys must correspond to the names of the
  // fields in the JSON object.
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      item: CafeItem.fromJson(json['item']),
      quantity: json['quantity'],
    );
  }
}
