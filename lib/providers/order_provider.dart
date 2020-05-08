import 'package:flutter/material.dart';

import 'item.dart';

class CartItem {
  final String id;
  final String name;
  final double price;
  final int quantity;

  CartItem({this.id, this.name, this.price, this.quantity});
}

class OrderProvider with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get getOrderItems {
      return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += (cartItem.price * cartItem.quantity);
    });

    return total;
  }

  void addItemToOrder(String id, double price, String name) {
      if(_items.containsKey(id)) {
        _items.update(id, (existingOrderItem) => CartItem(
          id: existingOrderItem.id,
          name: existingOrderItem.name,
          price: existingOrderItem.price,
          quantity: existingOrderItem.quantity + 1,
        ));
      } else {
        _items.putIfAbsent(id, () => CartItem(
          id: id,
          name: name,
          price: price,
          quantity: 1,
        ));
      }

      notifyListeners();
  }

  void removeItemFromOrder(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }


}