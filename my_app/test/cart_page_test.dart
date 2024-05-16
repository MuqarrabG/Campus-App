import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/pages/cart_page.dart';
import 'package:provider/provider.dart';
import 'package:my_app/models/cafe.dart';
import 'package:my_app/models/cart_item.dart';
import 'package:my_app/models/cafe_item.dart';
import 'package:my_app/models/order.dart';
import 'package:mockito/mockito.dart';
import 'package:my_app/components/cart_tile.dart';
import 'package:my_app/components/my_button.dart';

// Mock class for Order
class MockOrder extends Mock implements Order {}

void main() {
  group('CartPage', () {
    late Cafe cafe;
    late MockOrder mockOrder;

    setUp(() {
      cafe = Cafe();
      mockOrder = MockOrder();
      // Adding sample items to the cart
      final cafeItem = CafeItem(
        name: 'Coffee',
        basePrice: 3.5,
        imagePath: 'lib/images/coffee.jpg',
        isCoffee: true,
      );
      cafe.addItemToCart(cafeItem, 2);
    });

    testWidgets('displays the correct number of items', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: cafe,
          child: MaterialApp(
            home: CartPage(),
          ),
        ),
      );

      expect(find.byType(CartTile), findsNWidgets(cafe.userCart.length));
    });

    testWidgets('order button saves order, clears cart, and navigates to home page', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: cafe,
          child: MaterialApp(
            home: CartPage(),
            routes: {
              '/': (context) => Scaffold(body: Text('Home Page')),
            },
          ),
        ),
      );

      // Verify initial cart state
      expect(cafe.userCart.isNotEmpty, true);

      // Tap the order button
      await tester.tap(find.byType(MyButton));
      await tester.pumpAndSettle();

      // Verify cart is cleared and navigated to home page
      expect(cafe.userCart.isEmpty, true);
      expect(find.text('Home Page'), findsOneWidget);

      // Verify order dialog is shown
      expect(find.text('Order Successful'), findsOneWidget);
    });

    testWidgets('CartTile onPressed removes items from cart', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: cafe,
          child: MaterialApp(
            home: CartPage(),
          ),
        ),
      );

      // Verify initial cart state
      expect(cafe.userCart.length, 1);

      // Tap the delete button on CartTile
      await tester.tap(find.byIcon(Icons.delete).first);
      await tester.pumpAndSettle();

      // Verify item is removed from cart
      expect(cafe.userCart.isEmpty, true);
    });
  });
}
