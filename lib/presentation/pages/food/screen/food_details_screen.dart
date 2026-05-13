import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/controller/food_details_controller.dart';
import '../../../const/app_const_dimensions.dart';
import '../../../const/app_const_theme.dart';
import '../../../const/styles.dart';

class FoodDetailsScreen extends StatelessWidget {
  const FoodDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FoodDetailsController>(
      init: FoodDetailsController(),
      builder: (controller) {
        final food = controller.foodDetails;

        return Scaffold(
          backgroundColor: AppConstColor.backgroundWhite,
          body: Column(
            children: [
              // Top Image and Header Section
              _buildTopHeader(context, food),

              // Content Section
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(
                    Dimensions.PADDING_SIZE_EXTRA_LARGE,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        food['name'],
                        style: headline(context)?.copyWith(
                          fontSize: Dimensions.FONT_SIZE_OVER_EXTRA_LARGE,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: Dimensions.FREE_SIZE_SMALL),

                      // Rating and Orders Row
                      _buildStatsRow(context, food),
                      const SizedBox(height: Dimensions.FREE_SIZE_EXTRA_LARGE),

                      // Description
                      Text(
                        food['description'],
                        style: bodyMedium(context)?.copyWith(
                          color: AppConstColor.hintColor,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom Button
              _buildAddToCartButton(context, controller),
            ],
          ),
        );
      },
    );
  }

  /// Builds the top yellow section with the back button and food image
  Widget _buildTopHeader(BuildContext context, Map<String, dynamic> food) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppConstColor.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(Dimensions.RADIUS_OVER_EXTRA_LARGE),
          bottomRight: Radius.circular(Dimensions.RADIUS_OVER_EXTRA_LARGE),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            // Back Button
            Positioned(
              top: Dimensions.PADDING_SIZE_DEFAULT,
              left: Dimensions.PADDING_SIZE_DEFAULT,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  padding: const EdgeInsets.all(
                    Dimensions.PADDING_SIZE_EXTRA_SMALL,
                  ),
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
            // Product Image
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Image.network(
                  food['image'],
                  height: 250,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the Row for Rating and Order count
  Widget _buildStatsRow(BuildContext context, Map<String, dynamic> food) {
    return Row(
      children: [
        const Icon(Icons.star, color: AppConstColor.primaryColor, size: 18),
        const SizedBox(width: 4),
        Text(food['rating'], style: caption(context)),
        const SizedBox(width: Dimensions.PADDING_SIZE_LARGE),
        const Icon(
          Icons.shopping_basket,
          color: AppConstColor.primaryColor,
          size: 18,
        ),
        const SizedBox(width: 4),
        Text(food['orders'], style: caption(context)),
      ],
    );
  }

  /// Builds the large Add to Cart button at the bottom
  Widget _buildAddToCartButton(
    BuildContext context,
    FoodDetailsController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE,
        vertical: Dimensions.PADDING_SIZE_OVER_EXTRA_LARGE,
      ),
      child: SizedBox(
        width: double.infinity,
        height: Dimensions.BUTTON_DEFAULT_HIGHT,
        child: ElevatedButton(
          onPressed: controller.addToCart,
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
            "Add to Cart",
            style: headline(context)?.copyWith(
              color: AppConstColor.textWhiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
