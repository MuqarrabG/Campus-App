import 'package:flutter/material.dart';
import 'package:my_app/models/cafe_item.dart';
import 'package:my_app/models/cart_item.dart';

class Cafe extends ChangeNotifier {
  final List<CafeItem> _shop = [
    CafeItem(
      name: "Coffee", 
      basePrice: 3.50, 
      imagePath: "lib/images/coffee.jpg", 
      isCoffee: true
    ),
    CafeItem(
      name: "Iced Coffee", 
      basePrice: 4.50, 
      imagePath: "lib/images/iced_coffee.jpg", 
      isCoffee: false
    ),
    CafeItem(
      name: "Banana Bread", 
      basePrice: 3.50, 
      imagePath: "lib/images/banana_bread.jpg", 
      isCoffee: false
    ),
    CafeItem(
      name: "Crossant", 
      basePrice: 4.50, 
      imagePath: "lib/images/croissant.jpg", 
      isCoffee: false
    ),
    CafeItem(
      name: "Egg & Avacado on Toast", 
      basePrice: 8.50, 
      imagePath: "lib/images/egg_avo.jpg", 
      isCoffee: false
    ),
  ];

  // get cafe item list
  List<CafeItem> get cafe => _shop;

  // user cart
  List<CartItem> _userCart = [];

  // get user cart
  List<CartItem> get userCart => _userCart;

  // add item to cart
  void addItemToCart(CafeItem item, int quantity) {
    // Check if item already exists in cart
    final index = _userCart.indexWhere((cartItem) => cartItem.item == item);
    if (index >= 0) {
      // If item exists, increase the quantity
      _userCart[index].quantity += quantity;
    } else {
      // If item does not exist, add new item to cart
      _userCart.add(CartItem(item: item, quantity: quantity));
    }
    updateShopItem(0, CafeItem(
      name: "Coffee", 
      basePrice: 3.50, 
      imagePath: "lib/images/coffee.jpg", 
      isCoffee: true
    ),);
    notifyListeners();
  }

  // remove item from cart
  void removeItemFromCart(CartItem item) {
    _userCart.removeWhere((cartItem) => cartItem == item);
    notifyListeners();
  }

  double cartTotal() {
    double total = 0.0;
    _userCart.forEach((element) {
      total += element.item.price * element.quantity;
    });
    return total;
  }

  void clearCart() {
    _userCart.clear();
    notifyListeners();
  }

  void updateShopItem(int index, CafeItem newItem) {
    if (index >= 0 && index < _shop.length) {
      _shop[index] = newItem;
      notifyListeners();
    }
  }
}
