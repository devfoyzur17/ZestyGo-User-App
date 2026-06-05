import 'package:demo_app/presentation/routes/app_routes.dart';
import 'package:flutter/material.dart' hide MenuController;
import 'package:get/get.dart';
import 'package:demo_app/domain/controller/menu_controller.dart';

import '../../../const/app_const_dimensions.dart';
import '../../../const/app_const_theme.dart';
import '../../../const/styles.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MenuController>(
      init: MenuController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppConstColor.backgroundGray,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Page Title
                  Text(
                    "Menu",
                    style: headline(context)?.copyWith(
                      fontSize: Dimensions.FONT_SIZE_OVER_EXTRA_LARGE,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: Dimensions.FREE_SIZE_DEFAULT),

                  // Enhanced Horizontal Category Filter Loading Flow
                  controller.isCategoryLoading
                      ? _buildCategoryLoadingSkeleton() // Beautiful static chip loaders
                      : _buildCategoryFilter(controller),

                  const SizedBox(height: Dimensions.FREE_SIZE_EXTRA_LARGE),

                  // All Foods Section Header
                  _buildSectionHeader(context, "All Foods", showSeeAll: false),

                  // Enhanced Food Grid Loading Flow
                  controller.isFoodLoading
                      ? _buildFoodGridLoadingSkeleton() // Better clean grid placeholder cards
                      : _buildFoodGrid(controller),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// 1. Category Loading Skeleton: Shimmer ছাড়া ক্লিন ক্যাটালগ চিপস লোডার
  Widget _buildCategoryLoadingSkeleton() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 4, // Display 4 generic static placeholder chips
        separatorBuilder: (_, __) =>
            const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
        itemBuilder: (context, index) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            width: index == 0
                ? 90
                : (index == 1 ? 120 : 80), // Varied widths for realism
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            decoration: BoxDecoration(
              color: AppConstColor.backgroundWhite.withOpacity(0.6),
              borderRadius: BorderRadius.circular(
                Dimensions.RADIUS_OVER_EXTRA_LARGE,
              ),
            ),
            child: Center(
              child: Container(
                height: 12,
                decoration: BoxDecoration(
                  color: AppConstColor.hintColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// 2. Food Grid Loading Skeleton: গ্রিড লেআউট ঠিক রেখে প্রফেশনাল কার্ড লোডার
  Widget _buildFoodGridLoadingSkeleton() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4, // Load 4 structural temporary overlay grid cells
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: Dimensions.PADDING_SIZE_DEFAULT,
        crossAxisSpacing: Dimensions.PADDING_SIZE_DEFAULT,
        mainAxisExtent: 230,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: AppConstColor.cardColor.withOpacity(0.7),
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Mock Food Image Viewport Area
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppConstColor.backgroundGray.withOpacity(0.5),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(Dimensions.RADIUS_LARGE),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.fastfood_outlined,
                      color: AppConstColor.hintColor.withOpacity(0.2),
                      size: 40,
                    ),
                  ),
                ),
              ),
              // Mock Details Strip
              Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Mock Title Line
                    Container(
                      width: 100,
                      height: 14,
                      decoration: BoxDecoration(
                        color: AppConstColor.hintColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Mock Price & Rating Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 40,
                          height: 12,
                          decoration: BoxDecoration(
                            color: AppConstColor.hintColor.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        Container(
                          width: 50,
                          height: 14,
                          decoration: BoxDecoration(
                            color: AppConstColor.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Horizontal scrollable chips for category selection
  Widget _buildCategoryFilter(MenuController controller) {
    if (controller.categories.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: controller.categories.length,
        separatorBuilder: (_, __) =>
            const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
        itemBuilder: (context, index) {
          bool isSelected = controller.selectedCategoryIndex == index;
          return GestureDetector(
            onTap: () => controller.setCategory(index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppConstColor.primaryColor
                    : AppConstColor.backgroundWhite,
                borderRadius: BorderRadius.circular(
                  Dimensions.RADIUS_OVER_EXTRA_LARGE,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  controller.categories[index]['name'] ?? '',
                  style: bodyMedium(context)?.copyWith(
                    color: isSelected
                        ? AppConstColor.textWhiteColor
                        : AppConstColor.hintColor,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Standard header for sections
  Widget _buildSectionHeader(
    BuildContext context,
    String title, {
    bool showSeeAll = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: headline(context)),
          if (showSeeAll)
            Text(
              "See All",
              style: bodyMedium(context)?.copyWith(
                color: AppConstColor.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }

  /// Reusable 2-column food grid mapped to dynamic categories
  Widget _buildFoodGrid(MenuController controller) {
    if (controller.foodItems.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.only(top: 40),
          child: Text("No items available under this category."),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.foodItems.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: Dimensions.PADDING_SIZE_DEFAULT,
        crossAxisSpacing: Dimensions.PADDING_SIZE_DEFAULT,
        mainAxisExtent: 230,
      ),
      itemBuilder: (context, index) {
        var food = controller.foodItems[index];
        String foodImage = food['image'] ?? '';

        return InkWell(
          onTap: () {
            Get.toNamed(RouteName.FOOD_DETAILS_SCREEN, arguments: food);
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppConstColor.cardColor,
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(Dimensions.RADIUS_LARGE),
                      ),
                      child: foodImage.isNotEmpty
                          ? Image.network(
                              foodImage,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(
                                    Icons.broken_image,
                                    size: 50,
                                    color: Colors.grey,
                                  ),
                            )
                          : const Icon(
                              Icons.fastfood,
                              size: 50,
                              color: Colors.grey,
                            ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        food['name'] ?? '',
                        style: bodyMedium(
                          context,
                        )?.copyWith(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(

                            Icons.star,
                            color: AppConstColor.primaryColor,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "${food['rating'] ?? 0.0}",
                            style: caption(context),
                          ),
                          const Spacer(),
                          Text(
                            "৳${food['price'] ?? 0.0}",
                            style: bodyMedium(
                              context,
                            )?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
