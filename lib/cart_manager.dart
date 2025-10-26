import 'package:flutter/material.dart';

class CartManager {
  /// Global cart items with quantity
  static ValueNotifier<List<Map<String, dynamic>>> cartItems =
  ValueNotifier<List<Map<String, dynamic>>>([]);

  /// Add item (if exists, increase quantity)
  static void addItem(Map<String, String> item) {
    List<Map<String, dynamic>> current = cartItems.value;
    int index = current.indexWhere((i) => i['title'] == item['title']);
    if (index != -1) {
      current[index]['quantity'] += 1;
    } else {
      current.add({
        'title': item['title'],
        'price': item['price'],
        'image': item['image'],
        'quantity': 1,
      });
    }
    cartItems.value = List.from(current); // update ValueNotifier
  }

  /// Remove item completely
  static void removeItemAt(int index) {
    final current = List<Map<String, dynamic>>.from(cartItems.value);
    current.removeAt(index);
    cartItems.value = current;
  }

  /// Decrease quantity by 1
  static void decreaseItem(Map<String, dynamic> item) {
    List<Map<String, dynamic>> current = cartItems.value;
    int index = current.indexWhere((i) => i['title'] == item['title']);
    if (index != -1) {
      if (current[index]['quantity'] > 1) {
        current[index]['quantity'] -= 1;
      } else {
        current.removeAt(index);
      }
    }
    cartItems.value = List.from(current);
  }

  /// Clear all items
  static void clearCart() {
    cartItems.value = [];
  }

  /// Calculate total price (price * quantity)
  static int getTotal() {
    return cartItems.value.fold<int>(
      0,
          (sum, item) => sum +
          (int.parse(item['price'].toString()) * (item['quantity'] as int)),
    );
  }
}
