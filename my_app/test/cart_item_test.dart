import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/models/cart_item.dart';
import 'package:my_app/models/cafe_item.dart';

void main() {
  group('CartItem', () {
    final cafeItem = CafeItem(
      name: 'Coffee',
      basePrice: 3.5,
      imagePath: 'lib/images/coffee.jpg',
      isCoffee: true,
    );

    test('toJson returns a valid map representation', () {
      final cartItem = CartItem(item: cafeItem, quantity: 2);
      final json = cartItem.toJson();

      expect(json['item'], isNotNull);
      expect(json['quantity'], 2);
    });

    test('fromJson creates a valid CartItem object', () {
      final json = {
        'item': {
          'name': 'Coffee',
          'basePrice': 3.5,
          'imagePath': 'lib/images/coffee.jpg',
          'isCoffee': true,
          'extraShot': false,
          'size': 'small',
          'type': 'cappuccino',
          'milk': 'fullCream',
        },
        'quantity': 2,
      };

      final cartItem = CartItem.fromJson(json);

      expect(cartItem.item.name, 'Coffee');
      expect(cartItem.item.basePrice, 3.5);
      expect(cartItem.item.imagePath, 'lib/images/coffee.jpg');
      expect(cartItem.item.isCoffee, true);
      expect(cartItem.quantity, 2);
    });
  });
}
