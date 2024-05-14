import 'package:flutter/material.dart';
import 'package:my_app/models/cafeitem.dart';

class Cafe extends ChangeNotifier {
  // String name;
  // bool isOpen;

  // Cafe(this.name, this.isOpen);

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
  List<CafeItem> _userCart = [];

  // get user cart
  List<CafeItem> get userCart => _userCart;

  // add item to cart
  void addItemToCart(CafeItem item, int quantity) {
    _userCart.add(item);
    notifyListeners();
  }

  // remove item from cart
  void removeItemFromCart(CafeItem item) {
    _userCart.remove(item);
    notifyListeners();
  }
}
