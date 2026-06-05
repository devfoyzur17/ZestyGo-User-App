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
         if (controller.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final food = controller.foodData;

        return Scaffold(
          backgroundColor: AppConstColor.backgroundWhite,
          body: Column(
            children: [
              // Top descriptive image container component
              _buildTopHeader(context, food),

              // Scrollable card context detail layer
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(
                    Dimensions.PADDING_SIZE_EXTRA_LARGE,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Formatted item label title block
                      Text(
                        food['name'] ?? 'Unknown Item',
                        style: headline(context)?.copyWith(
                          fontSize: Dimensions.FONT_SIZE_OVER_EXTRA_LARGE,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: Dimensions.FREE_SIZE_SMALL),

                      // Social response indicators tracking row
                      _buildStatsRow(context, food),
                      const SizedBox(height: Dimensions.FREE_SIZE_EXTRA_LARGE),

                      // Ingredients or recipe text details explanation block
                      Text(
                        food['description'] != null &&
                                food['description'].toString().isNotEmpty
                            ? food['description']
                            : 'No descriptive text content is provided for this food preparation entry asset package.',
                        style: bodyMedium(context)?.copyWith(
                          color: AppConstColor.hintColor,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom purchase invocation trigger button
              _buildAddToCartButton(context, controller),
            ],
          ),
        );
      },
    );
  }

  /// Builds the top signature primary color section displaying custom assets
  Widget _buildTopHeader(BuildContext context, Map<String, dynamic> food) {
    String foodImage = food['image'] ?? '';

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
            // Safe pop tracking mechanism button
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

            // Image object mapping placeholder wrapper
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0, left: 24, right: 24),
                child: foodImage.isNotEmpty
                    ? Image.network(
                        foodImage,
                        height: 250,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                              Icons.broken_image,
                              size: 100,
                              color: Colors.white,
                            ),
                      )
                    : const Icon(
                        Icons.fastfood,
                        size: 100,
                        color: Colors.white,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds rating metrics display calculations layout row
  Widget _buildStatsRow(BuildContext context, Map<String, dynamic> food) {
    return Row(
      children: [
        const Icon(Icons.star, color: AppConstColor.primaryColor, size: 18),
        const SizedBox(width: 4),
        Text(
          "${food['rating'] ?? 0.0} Rating",
          style: caption(context)?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(width: Dimensions.PADDING_SIZE_LARGE),
        const Icon(
          Icons.shopping_basket,
          color: AppConstColor.primaryColor,
          size: 18,
        ),
        const SizedBox(width: 4),
        Text(
          // Uses fallback text if dynamic transaction logging counts are absent
          food['orders'] ?? '400+ Orders',
          style: caption(context)?.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  /// Builds sticky action confirmation deck element at base anchor point
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
          onPressed: () {
            controller.addToCart(context);
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
