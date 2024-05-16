import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/models/cafe_item.dart';

void main() {
  group('CafeItem', () {
    final cafeItem = CafeItem(
      name: 'Coffee',
      basePrice: 3.5,
      imagePath: 'lib/images/coffee.jpg',
      isCoffee: true,
    );

    test('toJson returns a valid map representation', () {
      final json = cafeItem.toJson();

      expect(json['name'], 'Coffee');
      expect(json['basePrice'], 3.5);
      expect(json['imagePath'], 'lib/images/coffee.jpg');
      expect(json['isCoffee'], true);
      expect(json['price'], 3.5);
      expect(json['extraShot'], false);
      expect(json['milk'], 'fullCream');
      expect(json['size'], 'small');
      expect(json['type'], 'cappuccino');
    });

    test('fromJson creates a valid CafeItem object', () {
      final json = {
        'name': 'Coffee',
        'basePrice': 3.5,
        'imagePath': 'lib/images/coffee.jpg',
        'isCoffee': true,
        'extraShot': false,
        'milk': 'fullCream',
        'size': 'small',
        'type': 'cappuccino',
      };

      final cafeItemFromJson = CafeItem.fromJson(json);

      expect(cafeItemFromJson.name, 'Coffee');
      expect(cafeItemFromJson.basePrice, 3.5);
      expect(cafeItemFromJson.imagePath, 'lib/images/coffee.jpg');
      expect(cafeItemFromJson.isCoffee, true);
      expect(cafeItemFromJson.extraShot, false);
      expect(cafeItemFromJson.milk, Milk.fullCream);
      expect(cafeItemFromJson.size, Size.small);
      expect(cafeItemFromJson.type, Type.cappuccino);
    });

    test('price calculation is correct', () {
      cafeItem.size = Size.regular;
      expect(cafeItem.price, 4.0);

      cafeItem.size = Size.large;
      expect(cafeItem.price, 4.5);

      cafeItem.milk = Milk.oatMilk;
      expect(cafeItem.price, 5.5);

      cafeItem.extraShot = true;
      expect(cafeItem.price, 6.2);
    });

    test('getter and setter for size work correctly', () {
      cafeItem.size = Size.large;
      cafeItem.milk = Milk.skimMilk;
      expect(cafeItem.size, Size.large);
      expect(cafeItem.price, 5.2);
    });

    test('getter and setter for milk work correctly', () {
      cafeItem.milk = Milk.almondMilk;
      expect(cafeItem.milk, Milk.almondMilk);
      expect(cafeItem.price, 6.2);
    });

    test('getter and setter for extra shot work correctly', () {
      cafeItem.extraShot = true;
      expect(cafeItem.extraShot, true);
      expect(cafeItem.price, 6.2);
    });

    test('getter and setter for type work correctly', () {
      cafeItem.type = Type.latte;
      expect(cafeItem.type, Type.latte);
    });
  });
}
