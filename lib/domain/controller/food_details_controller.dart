import 'package:demo_app/presentation/common_widget/custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../presentation/routes/app_routes.dart';
import 'cart_controller.dart';

class FoodDetailsController extends GetxController {

  Map<String, dynamic> foodData = {};
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    getPassedArguments();
  }


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
      update();
    }
  }


  void addToCart(BuildContext context) {

    final CartController cartController = Get.find<CartController>();


    cartController.addToCart(foodData);
    showCustomSnackBar(
      "${foodData['name'] ?? 'Item'} added to your cart!",
      context,
      isError: false,
    );

    Get.toNamed(RouteName.CART_SCREEN);
  }
}
