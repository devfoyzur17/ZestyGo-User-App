import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../const/app_const_dimensions.dart';

void showCustomSnackBar(
  String message,
  BuildContext context, {
  bool isError = false,
}) {
  Get.showSnackbar(
    GetSnackBar(
      backgroundColor: isError ? Colors.red : Theme.of(context).dividerColor,
      message: message,
      duration: const Duration(seconds: 2),
      snackStyle: SnackStyle.FLOATING,
      margin: EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
        vertical: Dimensions.PADDING_SIZE_DEFAULT * 2,
      ),
      borderRadius: 10,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      snackPosition: SnackPosition.BOTTOM,
    ),
  );
}
