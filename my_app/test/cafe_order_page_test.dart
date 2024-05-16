import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/pages/cafe_order_page.dart';
import 'package:provider/provider.dart';
import 'package:my_app/models/cafe.dart';
import 'package:my_app/models/cafe_item.dart';
import 'package:my_app/components/my_button.dart';

void main() {
  group('CafeOrderPage', () {
    late Cafe cafe;
    late CafeItem cafeItem;

    setUp(() {
      cafe = Cafe();
      cafeItem = CafeItem(
        name: 'Coffee',
        basePrice: 3.5,
        imagePath: 'lib/images/coffee.jpg',
        isCoffee: true,
      );
    });

    testWidgets('displays the correct initial UI elements', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: cafe,
          child: MaterialApp(
            home: CafeOrderPage(item: cafeItem, cafeName: 'Test Cafe'),
          ),
        ),
      );

      expect(find.text('Test Cafe Order'), findsOneWidget);
      expect(find.text('1'), findsOneWidget);
      expect(find.text('Extra Shot?'), findsOneWidget);
      expect(find.text('Size'), findsOneWidget);
      expect(find.text('Type'), findsOneWidget);
      expect(find.text('Milk'), findsOneWidget);
      expect(find.text('Add to cart'), findsOneWidget);
    });

    testWidgets('increment and decrement buttons update the quantity correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: cafe,
          child: MaterialApp(
            home: CafeOrderPage(item: cafeItem, cafeName: 'Test Cafe'),
          ),
        ),
      );

      // Verify initial quantity
      expect(find.text('1'), findsOneWidget);

      // Tap the increment button
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      // Verify updated quantity
      expect(find.text('2'), findsOneWidget);

      // Tap the decrement button
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();

      // Verify updated quantity
      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('option selections update the CafeItem properties correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: cafe,
          child: MaterialApp(
            home: CafeOrderPage(item: cafeItem, cafeName: 'Test Cafe'),
          ),
        ),
      );

      // Select extra shot
      await tester.tap(find.text('Extra Shot?').first);
      await tester.pump();

      // Verify extra shot
      expect(cafeItem.extraShot, true);

      // Select size
      await tester.tap(find.text('Regular').first);
      await tester.pump();

      // Verify size
      expect(cafeItem.size, Size.regular);

      // Select type
      await tester.tap(find.text('Latte').first);
      await tester.pump();

      // Verify type
      expect(cafeItem.type, Type.latte);

      // Select milk
      await tester.tap(find.text('Oat Milk').first);
      await tester.pump();

      // Verify milk
      expect(cafeItem.milk, Milk.oatMilk);
    });

    testWidgets('Add to cart button adds item to cart and navigates to home page', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: cafe,
          child: MaterialApp(
            home: CafeOrderPage(item: cafeItem, cafeName: 'Test Cafe'),
            routes: {
              '/': (context) => Scaffold(body: Text('Home Page')),
            },
          ),
        ),
      );

      // Verify initial cart state
      expect(cafe.userCart.isEmpty, true);

      // Tap the add to cart button
      await tester.tap(find.byType(MyButton));
      await tester.pumpAndSettle();

      // Verify item is added to cart
      expect(cafe.userCart.isNotEmpty, true);

      // Verify navigated to home page
      expect(find.text('Home Page'), findsOneWidget);

      // Verify success dialog is shown
      expect(find.text('Successfully added to cart'), findsOneWidget);
    });
  });
}
