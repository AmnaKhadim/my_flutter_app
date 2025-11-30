import 'package:flutter/material.dart';

class CartManager {
  /// Global cart with ValueNotifier for real-time UI update
  static ValueNotifier<List<Map<String, dynamic>>> cartItems =
  ValueNotifier<List<Map<String, dynamic>>>([]);

  /// Add item with full customization
  static void addItem(Map<String, dynamic> newItem) {
    List<Map<String, dynamic>> current = List.from(cartItems.value);

    // Same customization wala item dhundho
    int existingIndex = current.indexWhere((item) {
      return item['title'] == newItem['title'] &&
          item['cheese'] == newItem['cheese'] &&
          item['olives'] == newItem['olives'] &&
          item['spices'] == newItem['spices'];
    });

    if (existingIndex != -1) {
      // Same customization hai → quantity badhao
      current[existingIndex]['quantity'] += 1;
    } else {
      // Naya customized item → add karo with quantity 1
      current.add({
        ...newItem,
        'quantity': 1,
      });
    }

    cartItems.value = List.from(current); // trigger UI update
  }

  /// Decrease quantity or remove if 0
  static void decreaseQuantity(int index) {
    List<Map<String, dynamic>> current = List.from(cartItems.value);

    if (current[index]['quantity'] > 1) {
      current[index]['quantity'] -= 1;
    } else {
      current.removeAt(index);
    }

    cartItems.value = List.from(current);
  }

  /// Remove item completely
  static void removeItem(int index) {
    List<Map<String, dynamic>> current = List.from(cartItems.value);
    current.removeAt(index);
    cartItems.value = List.from(current);
  }

  /// Clear cart
  static void clearCart() {
    cartItems.value = [];
  }

  /// Get total amount
  static double get totalAmount {
    return cartItems.value.fold(
      0.0,
          (sum, item) => sum + (item['totalPrice'] as double) * (item['quantity'] as int),
    );
  }

  /// Get total items count (for cart badge)
  static int get itemCount {
    return cartItems.value.fold(0, (sum, item) => sum + (item['quantity'] as int));
  }
}