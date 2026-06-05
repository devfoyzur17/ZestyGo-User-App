import 'package:demo_app/presentation/pages/profile/screen/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/controller/cart_controller.dart';
import '../../../../domain/controller/profile_controller.dart';
import '../../../const/app_const_dimensions.dart';
import '../../../const/app_const_theme.dart';
import '../../../const/styles.dart';
import '../../../routes/app_routes.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Relying on a lazy-put global initialization instance lookup pattern
    return GetBuilder<CartController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppConstColor.backgroundGray,
          appBar: _buildAppBar(context),
          body: controller.cartItems.isEmpty
              ? _buildEmptyStateView(context)
              : Column(
                  children: [
                    // Scrollable item listing stack content view area
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(
                          Dimensions.PADDING_SIZE_DEFAULT,
                        ),
                        child: Column(
                          children: [
                            _buildCartItemsList(controller),
                            const SizedBox(
                              height: Dimensions.FREE_SIZE_DEFAULT,
                            ),
                            _buildDeliveryAddressTile(context),
                          ],
                        ),
                      ),
                    ),

                    // Sticky pricing breakdown block matching mockup baseline structure
                    _buildPricingCheckoutPanel(context, controller),
                  ],
                ),
        );
      },
    );
  }

  /// Renders a friendly fallback message when the state collection array is empty
  Widget _buildEmptyStateView(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.shopping_cart_outlined,
            size: 64,
            color: AppConstColor.hintColor,
          ),
          const SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
          Text(
            "Your shopping cart is currently empty",
            style: bodyMedium(
              context,
            )?.copyWith(color: AppConstColor.hintColor),
          ),
        ],
      ),
    );
  }

  /// Builds custom navigation App Bar with rounded back target action button
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
        "Cart",
        style: headline(context)?.copyWith(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
    );
  }

  /// Card wrapper generating product list view representations dynamically
  Widget _buildCartItemsList(CartController controller) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      decoration: BoxDecoration(
        color: AppConstColor.backgroundWhite,
        borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.cartItems.length,
        separatorBuilder: (_, __) =>
            const Divider(height: 32, color: AppConstColor.backgroundGray),
        itemBuilder: (context, index) {
          final item = controller.cartItems[index];
          String itemImage = item['image'] ?? '';

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Asset Thumbnail Image View Frame
              ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                child: itemImage.isNotEmpty
                    ? Image.network(
                        itemImage,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.broken_image, size: 70),
                      )
                    : const Icon(Icons.fastfood, size: 70),
              ),
              const SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),

              // Middle Description String Identifiers Block
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'] ?? 'Unknown Food',
                      style: bodyMedium(
                        context,
                      )?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['description'] != null &&
                              item['description'].toString().isNotEmpty
                          ? item['description']
                          : 'No additional description ingredients detailed.',
                      style: caption(
                        context,
                      )?.copyWith(color: AppConstColor.hintColor),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),

                    // Modifier increment and decrement action button layout row
                    Container(
                      decoration: BoxDecoration(
                        color: AppConstColor.backgroundGray,
                        borderRadius: BorderRadius.circular(
                          Dimensions.RADIUS_OVER_EXTRA_LARGE,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () => controller.decrementQuantity(index),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              child: Icon(Icons.remove, size: 16),
                            ),
                          ),
                          Text(
                            "${item['quantity']}",
                            style: bodyMedium(
                              context,
                            )?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: () => controller.incrementQuantity(index),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              child: Icon(Icons.add, size: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Item Unit cost label indicator node
              Text(
                "৳${item['price']}",
                style: bodyMedium(context)?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppConstColor.textBlackColor,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// Card widget displaying active package dispatch tracking metrics dynamically
  Widget _buildDeliveryAddressTile(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (profileController) {
        bool hasAddress = profileController.homeAddress.trim().isNotEmpty;

        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
            vertical: Dimensions.PADDING_SIZE_SMALL,
          ),
          decoration: BoxDecoration(
            color: AppConstColor.backgroundWhite,
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
          ),
          child: InkWell(
            onTap: () {
              Get.to(() => const EditProfileScreen());
            },
            child: Row(
              children: [
                // Dynamic Icon Container
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: AppConstColor.backgroundGray,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    profileController.userName == "Loading..."
                        ? Icons.hourglass_top_rounded
                        : (hasAddress
                              ? Icons.location_on_outlined
                              : Icons.add_location_alt_outlined),
                    color: hasAddress
                        ? AppConstColor.primaryColor
                        : Colors.redAccent,
                  ),
                ),
                const SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),

                // Dynamic Text Section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profileController.userName == "Loading..."
                            ? "Fetching location..."
                            : (hasAddress
                                  ? "Deliver to: ${profileController.homeAddress}"
                                  : "No Delivery Address Found"),
                        style: bodyMedium(context)?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: hasAddress
                              ? AppConstColor.textBlackColor
                              : Colors.redAccent,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        hasAddress
                            ? "Tap here to change your delivery details"
                            : "Tap here to add your home/delivery address",
                        style: caption(
                          context,
                        )?.copyWith(color: AppConstColor.hintColor),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: AppConstColor.hintColor,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Sticky pricing sheet panel footer layer displaying grand totals calculations
  Widget _buildPricingCheckoutPanel(
    BuildContext context,
    CartController controller,
  ) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_LARGE),
      decoration: const BoxDecoration(
        color: AppConstColor.backgroundWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimensions.RADIUS_OVER_EXTRA_LARGE),
          topRight: Radius.circular(Dimensions.RADIUS_OVER_EXTRA_LARGE),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Checkout Summary Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Checkout",
                  style: bodyMedium(
                    context,
                  )?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  "25-35 mins",
                  style: bodyMedium(
                    context,
                  )?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Cost breakdowns mapping rows
            _buildPriceRow(
              context,
              "Subtotal",
              "৳${controller.subtotal.toStringAsFixed(2)}",
            ),
            const SizedBox(height: 8),
            _buildPriceRow(
              context,
              "Delivery Fee",
              "৳${controller.deliveryFee.toStringAsFixed(2)}",
            ),
            const SizedBox(height: 8),
            _buildPriceRow(
              context,
              "Discount",
              "-৳${controller.discount.toStringAsFixed(2)}",
            ),
            const Divider(height: 24, thickness: 1),

            // Absolute total payable value text component block
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: headline(
                    context,
                  )?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  "৳${controller.grandTotal.toStringAsFixed(2)}",
                  style: headline(
                    context,
                  )?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

            // Proceed Confirmation Button Layer
            SizedBox(
              width: double.infinity,
              height: Dimensions.BUTTON_DEFAULT_HIGHT,
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(
                    RouteName.CHECKOUT_SCREEN,
                  ); // Navigates seamlessly to our dynamic checkout screen
                },
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
                child: Text(
                  "Continue",
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
    );
  }

  /// Tiny presentation text matrix generator utility row helper element
  Widget _buildPriceRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: bodyMedium(context)?.copyWith(color: AppConstColor.hintColor),
        ),
        Text(
          value,
          style: bodyMedium(
            context,
          )?.copyWith(color: AppConstColor.textBlackColor),
        ),
      ],
    );
  }
}
