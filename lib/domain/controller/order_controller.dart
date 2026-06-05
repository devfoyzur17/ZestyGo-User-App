import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Live stream storage arrays
  List<Map<String, dynamic>> activeOrders = [];
  List<Map<String, dynamic>> pastOrders = [];

  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    listenToUserOrders();
  }

  /// Establishes a live dynamic database listener targeting active customer sessions
  void listenToUserOrders() {
    try {
      User? currentUser = _auth.currentUser;

      if (currentUser == null) {
        isLoading = false;
        update();
        return;
      }

      // Query database collection matching the current user's uid in descending date order
      _firestore
          .collection('orders')
          .where('userId', isEqualTo: currentUser.uid)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .listen(
            (QuerySnapshot snapshot) {
          activeOrders.clear();
          pastOrders.clear();

          for (var doc in snapshot.docs) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

            // Parsing model parameters mapping directly onto local arrays
            Map<String, dynamic> orderItem = {
              'orderId': doc.id,
              'status': data['status'] ?? 'pending',
              'totalAmount': double.tryParse(data['totalAmount'].toString()) ?? 0.0,
              'paymentMethod': data['paymentMethod'] ?? 'cash',
              'items': data['items'] ?? [],
              'location': data['deliveryAddress']?['address'] ?? 'Mirpur, Dhaka',
              'createdAt': data['createdAt'],
            };

            // Convert status to lowercase to avoid case-sensitivity mistakes
            String orderStatus = (data['status'] ?? 'pending').toString().toLowerCase();

            // Separating active lifecycle orders from historically completed runs
            if (orderStatus == 'delivered' || orderStatus == 'cancelled') {
              pastOrders.add(orderItem);
            } else {
              activeOrders.add(orderItem); // "pending", "accepted", "processing" যাবে Active-এ
            }
          }

          isLoading = false;
          update(); // Force UI repaint loop instantly upon dynamic stream data changes
        },
        onError: (error) {
          isLoading = false;
          update();
        },
      );
    } catch (e) {
      isLoading = false;
      update();
      Get.snackbar("Initialization Error", e.toString());
    }
  }
}