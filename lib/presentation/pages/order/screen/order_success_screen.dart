import 'package:demo_app/presentation/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../const/app_const_dimensions.dart';
import '../../../const/app_const_theme.dart';
import '../../../const/styles.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstColor.backgroundWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_LARGE),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Big Circular Success Checkmark Icon Indicator Area
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppConstColor.primaryColor.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.check_circle,
                    size: 80,
                    color: AppConstColor.primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: Dimensions.FREE_SIZE_EXTRA_LARGE),

              // Success Celebration Header Text Labels
              Text(
                "Order Placed Successfully!",
                style: headline(context)?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: Dimensions.FONT_SIZE_OVER_EXTRA_LARGE,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

              // Friendly Informative Subtext Description
              Text(
                "Your food order has been securely validated and accepted by the kitchen. Get ready to enjoy your delicious meal!",
                style: bodyMedium(context)?.copyWith(
                  color: AppConstColor.hintColor,
                ),
                textAlign: TextAlign.center,
              ),

              const Spacer(),

              // Action Navigation Button: Direct route fallback linking back to Home Screen
              SizedBox(
                width: double.infinity,
                height: Dimensions.BUTTON_DEFAULT_HIGHT,
                child: ElevatedButton(
                  onPressed: () {
                    // Tearing down navigation history tracks completely and resetting routing back to Home View Layout Base
                    Get.offAllNamed(RouteName.DASHBOARD_SCREEN);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstColor.primaryColor,
                    foregroundColor: AppConstColor.textWhiteColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimensions.RADIUS_OVER_EXTRA_LARGE),
                    ),
                  ),
                  child: Text(
                    "Back to Home",
                    style: headline(context)?.copyWith(
                      color: AppConstColor.textWhiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}