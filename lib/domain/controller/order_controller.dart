import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;


  List<Map<String, dynamic>> activeOrders = [];
  List<Map<String, dynamic>> pastOrders = [];

  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    listenToUserOrders();
  }


  void listenToUserOrders() {
    try {
      User? currentUser = _auth.currentUser;

      if (currentUser == null) {
        isLoading = false;
        update();
        return;
      }


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


            Map<String, dynamic> orderItem = {
              'orderId': doc.id,
              'status': data['status'] ?? 'pending',
              'totalAmount': double.tryParse(data['totalAmount'].toString()) ?? 0.0,
              'paymentMethod': data['paymentMethod'] ?? 'cash',
              'items': data['items'] ?? [],
              'location': data['deliveryAddress']?['address'] ?? 'Mirpur, Dhaka',
              'createdAt': data['createdAt'],
            };


            String orderStatus = (data['status'] ?? 'pending').toString().toLowerCase();


            if (orderStatus == 'delivered' || orderStatus == 'cancelled') {
              pastOrders.add(orderItem);
            } else {
              activeOrders.add(orderItem);
            }
          }

          isLoading = false;
          update();
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