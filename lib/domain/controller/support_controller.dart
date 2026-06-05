import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupportController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Form Controllers
  final TextEditingController messageController = TextEditingController();
  bool isSubmitting = false;

  // Local Static FAQ Data
  List<Map<String, dynamic>> faqs = [
    {
      'question': 'How can I track my live order?',
      'answer': 'Go to the "Orders" tab from the bottom navigation bar to track all of your real-time ongoing food orders.',
      'isExpanded': false,
    },
    {
      'question': 'What are the available payment methods?',
      'answer': 'We currently support Cash on Delivery (COD) and multiple secure online payment gateways including bKash, Nagad, and Credit/Debit cards.',
      'isExpanded': false,
    },
    {
      'question': 'How can I cancel my order?',
      'answer': 'You can cancel your order within 5 minutes of placing it by calling our customer support helpline directly.',
      'isExpanded': false,
    },
  ];

  /// Toggles the FAQ accordion item state
  void toggleFaq(int index) {
    faqs[index]['isExpanded'] = !faqs[index]['isExpanded'];
    update();
  }

  /// Submits the customer support ticket to Firebase Firestore
  Future<void> submitTicket() async {
    String msg = messageController.text.trim();
    if (msg.isEmpty) {
      Get.snackbar("Required", "Please write your message before submitting.");
      return;
    }

    try {
      isSubmitting = true;
      update();

      User? currentUser = _auth.currentUser;
      DocumentReference ticketRef = _firestore.collection('support_tickets').doc();

      await ticketRef.set({
        'ticketId': ticketRef.id,
        'userId': currentUser?.uid ?? 'guest_user',
        'userEmail': currentUser?.email ?? 'No Email',
        'userName': currentUser?.displayName ?? 'Anonymous User',
        'message': msg,
        'status': 'open',
        'createdAt': FieldValue.serverTimestamp(),
      });

      messageController.clear();
      isSubmitting = false;
      update();

      Get.snackbar(
        "Success",
        "Your message has been sent successfully. Our team will contact you soon!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

    } catch (e) {
      isSubmitting = false;
      update();
      Get.snackbar("Error", "Failed to submit ticket: ${e.toString()}");
    }
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}