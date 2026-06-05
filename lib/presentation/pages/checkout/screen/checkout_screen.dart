import 'package:demo_app/presentation/pages/profile/screen/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/controller/checkout_controller.dart';
import '../../../../domain/controller/profile_controller.dart';
import '../../../const/app_const_dimensions.dart';
import '../../../const/app_const_theme.dart';
import '../../../const/styles.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckoutController>(
      init: CheckoutController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppConstColor.backgroundGray,
          appBar: _buildAppBar(context),
          body: Padding(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Address and Delivery details information section wrapper
                _buildDeliveryDetailsCard(context),
                const SizedBox(height: Dimensions.FREE_SIZE_EXTRA_LARGE),

                // Payment Options Section Header Label Title
                _buildSectionTitle(context, "Payment Method"),
                const SizedBox(height: Dimensions.FREE_SIZE_SMALL),

                // Cash and Online Payment choices mapping options cards block
                _buildPaymentOptions(context, controller),
                const Spacer(),

                // Bottom absolute total pricing and execution validation layout trigger panel
                _buildBottomOrderPanel(context, controller),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Builds custom navigation App Bar with circular fallback action pop routing engine button
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            decoration: const BoxDecoration(
              color: AppConstColor.backgroundWhite,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back,
              color: AppConstColor.textBlackColor,
            ),
          ),
        ),
      ),
      title: Text(
        "Checkout",
        style: headline(context)?.copyWith(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
    );
  }

  /// Builds the delivery tracking parameter context text stack card layout module dynamically
  Widget _buildDeliveryDetailsCard(BuildContext context) {
    // Find existing ProfileController instance to read active user account variables
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (profileController) {
        // Fallback strategy check in case user profile variables are empty strings inside Firestore
        String dynamicAddress = profileController.homeAddress.trim().isNotEmpty
            ? profileController.homeAddress
            : "No Delivery Address Found";

        // Dynamic phone fallback configuration handler
        String dynamicPhone = profileController.userPhone.trim().isNotEmpty
            ? profileController.userPhone
            : "No Phone Number Found"; // <-- সম্পূর্ণ ডাইনামিক করা হলো

        return Container(
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          decoration: BoxDecoration(
            color: AppConstColor.backgroundWhite,
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
          ),
          child: Column(
            children: [
              // Dynamic Home Location Section Node
              _buildInfoTile(
                context,
                Icons.home_outlined,
                "Home",
                dynamicAddress,
                onTap: () {
                  // Direct user straight onto the profile modification panel to add/change locations
                  Get.to(() => const EditProfileScreen());
                },
              ),
              const Divider(height: 24, color: AppConstColor.backgroundGray),

              // Dynamic Customer Contacts Phone Node
              _buildInfoTile(
                context,
                Icons.phone_outlined,
                "Phone",
                dynamicPhone,
                onTap: () {
                  Get.to(() => const EditProfileScreen());
                },
              ),
              const Divider(height: 24, color: AppConstColor.backgroundGray),

              // Delivery Estimated Time Tracking Node
              _buildInfoTile(
                context,
                Icons.access_time,
                "Delivery Time",
                "25-35 mins",
                onTap: null, // Static information window row context
              ),
            ],
          ),
        );
      },
    );
  }

  /// Reusable list component row blueprint helper function targeting informational parameters
  /// Reusable list component row blueprint helper function targeting informational parameters
  Widget _buildInfoTile(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle, {
    VoidCallback? onTap, // Optional tap listener argument
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: AppConstColor.backgroundGray,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppConstColor.hintColor, size: 20),
          ),
          const SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: bodyMedium(
                    context,
                  )?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: caption(
                    context,
                  )?.copyWith(color: AppConstColor.hintColor),
                ),
              ],
            ),
          ),
          if (onTap !=
              null) // Only show arrow vector icon if rows are active triggers
            const Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: AppConstColor.hintColor,
            ),
        ],
      ),
    );
  }

  /// Heading tag decorator component wrapper generator node
  Widget _buildSectionTitle(BuildContext context, String text) {
    return Text(
      text,
      style: headline(context)?.copyWith(
        fontSize: Dimensions.FONT_SIZE_LARGE,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  /// Builds a reactive radio configuration cluster map matrix block for choosing payment routes
  Widget _buildPaymentOptions(
    BuildContext context,
    CheckoutController controller,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: AppConstColor.backgroundWhite,
        borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
      ),
      child: Column(
        children: [
          // Cash Payment Method Entry View Option Block
          _buildPaymentRowItem(
            context,
            title: "Cash",
            iconWidget: const Icon(
              Icons.attach_money,
              color: Colors.amber,
              size: 24,
            ),
            isSelected: controller.selectedPaymentMethod == 'cash',
            onTap: () => controller.changePaymentMethod('cash'),
          ),
          const Divider(height: 1, color: AppConstColor.backgroundGray),

          // Online Payment Method Entry View Option Block
          _buildPaymentRowItem(
            context,
            title: "Online Payment",
            iconWidget: const Icon(
              Icons.credit_card,
              color: Colors.deepOrange,
              size: 24,
            ),
            isSelected: controller.selectedPaymentMethod == 'online',
            onTap: () => controller.changePaymentMethod('online'),
          ),
        ],
      ),
    );
  }

  /// Dynamic list element generator rendering target item components inside payment matrix
  Widget _buildPaymentRowItem(
    BuildContext context, {
    required String title,
    required Widget iconWidget,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
          vertical: Dimensions.PADDING_SIZE_LARGE,
        ),
        child: Row(
          children: [
            iconWidget,
            const SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
            Expanded(
              child: Text(
                title,
                style: bodyMedium(
                  context,
                )?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected
                  ? AppConstColor.textBlackColor
                  : AppConstColor.hintColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  /// Bottom sticky actionable navigation footer layer displaying totals computations layout bounds
  Widget _buildBottomOrderPanel(
    BuildContext context,
    CheckoutController controller,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total",
              style: headline(context)?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              "৳${controller.totalAmount.toStringAsFixed(2)}",
              style: headline(context)?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

        // Order execution pipeline confirmation submission system button
        SizedBox(
          width: double.infinity,
          height: Dimensions.BUTTON_DEFAULT_HIGHT,
          child: ElevatedButton(
            // If controller is loading, pass null to disable clicking completely
            onPressed: controller.isLoading
                ? null
                : () => controller.placeOrder(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConstColor.primaryColor,
              foregroundColor: AppConstColor.textWhiteColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  Dimensions.RADIUS_OVER_EXTRA_LARGE,
                ),
              ),
            ),
            child: controller.isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: AppConstColor.textWhiteColor,
                      strokeWidth: 2.5,
                    ),
                  )
                : Text(
                    "Place Order",
                    style: headline(context)?.copyWith(
                      color: AppConstColor.textWhiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
