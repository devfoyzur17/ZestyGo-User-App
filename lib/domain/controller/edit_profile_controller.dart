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


  Future<void> loadCurrentUserData() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser == null) return;


      emailController.text = currentUser.email ?? "";
      profileImage = currentUser.photoURL ?? "";


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

        await _firestore.collection('users').doc(currentUser.uid).update({
          'name': name,
          'phone': phone,
          'homeAddress': home,
        });


        if (Get.isRegistered<ProfileController>()) {
          Get.find<ProfileController>().fetchUserProfileAndStats();
        }

        Get.back();
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