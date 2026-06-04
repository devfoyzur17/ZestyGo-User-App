import 'package:demo_app/presentation/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthController extends GetxController {
  // Firebase Instances
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Text Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordHidden = true;
  bool isLoading = false;

  // Password hide/show toggle
  void togglePasswordVisibility() {
    isPasswordHidden = !isPasswordHidden;
    update();
  }

  // --- SIGN UP METHOD ---
  Future<void> signUpUser(String role) async {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      Get.snackbar(
        "Error",
        "Email and Password cannot be empty",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading = true;
      update(); // UI-তে লোডার দেখানোর জন্য

      // 1. Firebase Auth-e user create
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

      User? user = userCredential.user;

      // 2. Firestore-e user identity (Role) save kora
      if (user != null) {
        await _db.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'name': nameController.text.trim(),
          'email': emailController.text.trim(),
          'role': role, // 'restaurant' অথবা 'customer'
          'createdAt': FieldValue.serverTimestamp(),
        });

        Get.snackbar(
          "Success",
          "Account created successfully!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        _navigateToDashboard(role);
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Auth Error",
        e.message ?? "Something went wrong",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  // --- LOGIN METHOD ---
  Future<void> loginUser() async {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill all fields",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading = true;
      update();

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      User? user = userCredential.user;

      if (user != null) {
        DocumentSnapshot userDoc = await _db
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          String role = userDoc.get('role');
          _navigateToDashboard(role);
        } else {
          Get.snackbar(
            "Error",
            "User data not found in database",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent,
            colorText: Colors.white,
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Login Error",
        e.message ?? "Wrong credentials",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  // --- LOGOUT METHOD ---
  Future<void> logoutUser() async {
    await _auth.signOut();
    _clearControllers();
    Get.offAllNamed('/login');
  }

  // --- HELPER METHODS ---
  void _navigateToDashboard(String role) {
    _clearControllers();

    Get.offAllNamed(RouteName.DASHBOARD_SCREEN);
  }

  void _clearControllers() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
