import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../../../domain/controller/cart_controller.dart';
import '../../presentation/pages/order/screen/order_success_screen.dart';

class CheckoutController extends GetxController {
  final CartController _cartController = Get.find<CartController>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Instance of Firebase Authentication to track the logged-in user
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String selectedPaymentMethod = 'cash';
  bool isLoading = false;

  double get totalAmount => _cartController.grandTotal;

  void changePaymentMethod(String method) {
    selectedPaymentMethod = method;
    update();
  }

  /// Handles order placement and securely appends current user's identity details
  Future<void> placeOrder() async {
    if (isLoading) return;

    if (_cartController.cartItems.isEmpty) {
      Get.snackbar(
        "Order Failed",
        "Your active checkout cart state session is empty!",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isLoading = true;
      update();

      User? currentUser = _auth.currentUser;

      if (currentUser == null) {
        isLoading = false;
        update();
        Get.snackbar(
          "Authentication Required",
          "Please log in or create an account to place an order.",
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      DocumentReference orderRef = _firestore.collection('orders').doc();


      Map<String, dynamic> orderPayload = {
        'orderId': orderRef.id,

        // --- User Tracking Fields ---
        'userId': currentUser.uid,
        'userEmail': currentUser.email ?? 'No Email',
        'userName': currentUser.displayName ?? 'Guest User',


        'paymentMethod': selectedPaymentMethod,
        'totalAmount': totalAmount,
        'deliveryFee': _cartController.deliveryFee,
        'discount': _cartController.discount,
        'subtotal': _cartController.subtotal,
        'deliveryAddress': {
          'title': 'Home',
          'address': 'Mirpur, Dhaka',
          'phone': currentUser.phoneNumber ?? '01758695235',
          'expectedTime': '25-35 mins'
        },
        'items': _cartController.cartItems.map((item) => {
          'id': item['id'] ?? '',
          'name': item['name'] ?? '',
          'price': double.tryParse(item['price'].toString()) ?? 0.0,
          'quantity': int.tryParse(item['quantity'].toString()) ?? 1,
          'image': item['image'] ?? '',
        }).toList(),
        'createdAt': FieldValue.serverTimestamp(),
        'status': 'pending',
      };


      await orderRef.set(orderPayload);

      _cartController.cartItems.clear();
      _cartController.update();

      isLoading = false;
      update();

      Get.offAll(() => const OrderSuccessScreen());

    } catch (e) {
      isLoading = false;
      update();

      Get.snackbar(
        "Server Error",
        "Failed synchronizing transaction data parameters: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}