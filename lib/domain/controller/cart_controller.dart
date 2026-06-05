import 'package:get/get.dart';

class CartController extends GetxController {
  // Reactive target array containing dynamic active food products loaded in cart
  List<Map<String, dynamic>> cartItems = [];

  // Price modifier constants
  final double deliveryFee = 50.00;
  final double discount = 0.00;

  /// Adds a new product map dynamically or increments quantity if it exists
  void addToCart(Map<String, dynamic> food) {
    // Check if the product item matches an existing entry inside the cart state array
    int existingIndex = cartItems.indexWhere(
      (item) => item['id'] == food['id'],
    );

    if (existingIndex != -1) {
      // Item exists, increment quantitative value counter
      cartItems[existingIndex]['quantity']++;
    } else {
      // New distinct entry item, push complete data map with base layer variables
      cartItems.add({
        'id': food['id'] ?? '',
        'name': food['name'] ?? '',
        'description': food['description'] ?? '',
        'price': double.tryParse(food['price'].toString()) ?? 0.0,
        'quantity': 1,
        'image': food['image'] ?? '',
      });
    }
    update(); // Notifies the layout builder tree to repaint state changes
  }

  /// Increments quantity value tracker metric for a specified cart entry item
  void incrementQuantity(int index) {
    cartItems[index]['quantity']++;
    update();
  }

  /// Decrements quantity and removes item from array listing if count drops below 1
  void decrementQuantity(int index) {
    if (cartItems[index]['quantity'] > 1) {
      cartItems[index]['quantity']--;
    } else {
      cartItems.removeAt(index);
    }
    update();
  }

  /// Computes cumulative price summation value totals dynamically
  double get subtotal {
    double total = 0.0;
    for (var item in cartItems) {
      double priceValue = double.tryParse(item['price'].toString()) ?? 0.0;
      int qtyValue = int.tryParse(item['quantity'].toString()) ?? 1;
      total += priceValue * qtyValue;
    }
    return total;
  }

  /// Returns final calculated sum value accounting for delivery fee updates
  double get grandTotal {
    if (cartItems.isEmpty) return 0.0;
    return subtotal + deliveryFee - discount;
  }
}
