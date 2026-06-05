import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/controller/profile_controller.dart';

class EditProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Text Editing Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController homeController = TextEditingController();

  bool isLoading = true;
  bool isSaving = false;
  String profileImage = "";

  @override
  void onInit() {
    super.onInit();
    loadCurrentUserData();
  }

  /// Fetches existing database states to populate text controllers on screen initialization
  Future<void> loadCurrentUserData() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser == null) return;

      // Base initialization directly via Firebase Auth data structure
      emailController.text = currentUser.email ?? "";
      profileImage = currentUser.photoURL ?? "";

      // Load additional dynamic fields from Firestore Document snapshot
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(currentUser.uid).get();

      if (userDoc.exists && userDoc.data() != null) {
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
        nameController.text = data['name'] ?? "";
        phoneController.text = data['phone'] ?? "";
        homeController.text = data['homeAddress'] ?? "";
      }

      isLoading = false;
      update();
    } catch (e) {
      isLoading = false;
      update();
      Get.snackbar("Error Loading Profile", e.toString());
    }
  }

  /// Updates modified user specifications into Cloud Firestore
  Future<void> updateProfileData() async {
    String name = nameController.text.trim();
    String phone = phoneController.text.trim();
    String home = homeController.text.trim();

    if (name.isEmpty) {
      Get.snackbar("Validation Error", "Name field cannot remain empty.");
      return;
    }

    try {
      isSaving = true;
      update();

      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        // 1. Update fields inside Firestore Document reference tree
        await _firestore.collection('users').doc(currentUser.uid).update({
          'name': name,
          'phone': phone,
          'homeAddress': home,
        });

        // 2. Sync and force-update the active ProfileController so the previous screen updates instantly
        if (Get.isRegistered<ProfileController>()) {
          Get.find<ProfileController>().fetchUserProfileAndStats();
        }

        Get.back(); // Return to previous layout screen stack upon success pipeline execution
        Get.snackbar(
          "Success",
          "Profile information updated successfully!",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar("Update Failed", e.toString());
    } finally {
      isSaving = false;
      update();
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    homeController.dispose();
    super.onClose();
  }
}