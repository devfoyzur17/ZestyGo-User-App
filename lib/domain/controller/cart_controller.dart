import 'package:get/get.dart';

class CartController extends GetxController {
  // Reactive target array containing dynamic active food products loaded in cart
  List<Map<String, dynamic>> cartItems = [];

  // Price modifier constants
  final double deliveryFee = 50.00;
  final double discount = 0.00;


  void addToCart(Map<String, dynamic> food) {

    int existingIndex = cartItems.indexWhere(
      (item) => item['id'] == food['id'],
    );

    if (existingIndex != -1) {

      cartItems[existingIndex]['quantity']++;
    } else {

      cartItems.add({
        'id': food['id'] ?? '',
        'name': food['name'] ?? '',
        'description': food['description'] ?? '',
        'price': double.tryParse(food['price'].toString()) ?? 0.0,
        'quantity': 1,
        'image': food['image'] ?? '',
      });
    }
    update();
  }


  void incrementQuantity(int index) {
    cartItems[index]['quantity']++;
    update();
  }


  void decrementQuantity(int index) {
    if (cartItems[index]['quantity'] > 1) {
      cartItems[index]['quantity']--;
    } else {
      cartItems.removeAt(index);
    }
    update();
  }


  double get subtotal {
    double total = 0.0;
    for (var item in cartItems) {
      double priceValue = double.tryParse(item['price'].toString()) ?? 0.0;
      int qtyValue = int.tryParse(item['quantity'].toString()) ?? 1;
      total += priceValue * qtyValue;
    }
    return total;
  }


  double get grandTotal {
    if (cartItems.isEmpty) return 0.0;
    return subtotal + deliveryFee - discount;
  }
}
