import 'dart:convert';
import 'package:my_app/models/cart_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Order {
  static const String _ordersKey = 'orders';

  // Save a new order
  static Future<void> saveOrder(List<CartItem> cartItems) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> orders = prefs.getStringList(_ordersKey) ?? [];
    orders.add(jsonEncode(cartItems.map((item) => item.toJson()).toList()));
    await prefs.setStringList(_ordersKey, orders);
  }

  // Retrieve all orders
  static Future<List<List<CartItem>>> getOrders() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> orders = prefs.getStringList(_ordersKey) ?? [];
    return orders.map((order) {
      List<dynamic> jsonItems = jsonDecode(order);
      return jsonItems.map((jsonItem) => CartItem.fromJson(jsonItem)).toList();
    }).toList();
  }

  // Clear all orders
  static Future<void> clearOrders() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_ordersKey);
  }
}
