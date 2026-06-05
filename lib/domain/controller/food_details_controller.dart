import 'package:demo_app/presentation/common_widget/custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../presentation/routes/app_routes.dart';
import 'cart_controller.dart';

class FoodDetailsController extends GetxController {
  // Reactive target storage container map for runtime parsing
  Map<String, dynamic> foodData = {};
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    getPassedArguments();
  }

  /// Extracts arguments transmitted during the routing process transition
  void getPassedArguments() {
    try {
      isLoading = true;
      update();

      if (Get.arguments != null && Get.arguments is Map<String, dynamic>) {
        foodData = Get.arguments as Map<String, dynamic>;
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed processing details payload: ${e.toString()}",
      );
    } finally {
      isLoading = false;
      update(); // Notifies the screen view elements to paint content onto the canvas
    }
  }

  /// Handles adding the active menu selection item to user checkout records
  void addToCart(BuildContext context) {
    // Find the global active instances of the cart tracker controller
    final CartController cartController = Get.find<CartController>();

    // Pass current dynamic food details into the dynamic cart state engine
    cartController.addToCart(foodData);
    showCustomSnackBar(
      "${foodData['name'] ?? 'Item'} added to your cart!",
      context,
      isError: false,
    );

    Get.toNamed(RouteName.CART_SCREEN);
  }
}
