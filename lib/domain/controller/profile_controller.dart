import 'package:get/get.dart';

class ProfileController extends GetxController {
  // Sample user data
  String userName = "Harry Brook.";
  int totalOrders = 15;

  // Navigation or action methods
  void onEditProfile() {
    print("Edit Profile Tapped");
  }

  void onMenuTap(String route) {
    print("Navigating to: $route");
  }
}