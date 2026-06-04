import 'package:demo_app/presentation/const/app_const_assets.dart';
import 'package:demo_app/presentation/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/controller/home_controller.dart';
import '../../../const/app_const_dimensions.dart';
import '../../../const/app_const_theme.dart';
import '../../../const/styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppConstColor.backgroundGray,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  const SizedBox(height: Dimensions.FREE_SIZE_EXTRA_LARGE),
                  _buildPromoBanner(),
                  const SizedBox(height: Dimensions.FREE_SIZE_EXTRA_LARGE),

                  // --- Dynamic Category Segment Container ---
                  controller.isCategoryLoading
                      ? const SizedBox(
                          height: 90,
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : _buildCategoryList(controller),

                  const SizedBox(height: Dimensions.FREE_SIZE_OVER_EXTRA_LARGE),
                  _buildSectionTitle(
                    context,
                    "Popular Foods",
                    showSeeAll: false,
                  ),
                  _buildFoodGrid(controller, isPopular: true),
                  const SizedBox(height: Dimensions.FREE_SIZE_EXTRA_LARGE),
                  _buildSectionTitle(context, "All Foods", showSeeAll: true),
                  _buildFoodGrid(controller, isPopular: false),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// User Profile Header Section
  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppConstColor.dividerColor, width: 1),
          ),
          child: CircleAvatar(
            radius: 25,
            backgroundColor: AppConstColor.backgroundWhite,
            child: Image.asset(
              AppConstAssets.userIcon,
              color: AppConstColor.textBlackColor,
            ),
          ),
        ),
        const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Harry Brook", style: headline(context)),
            Text("brook@gmail.com", style: caption(context)),
          ],
        ),
      ],
    );
  }

  /// Single Image Promo Banner
  Widget _buildPromoBanner() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
      child: Image.network(
        'https://img.freepik.com/free-vector/flat-food-sale-background_23-2149167390.jpg',
        width: double.infinity,
        height: 150,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            height: 150,
            width: double.infinity,
            color: AppConstColor.dividerColor.withOpacity(0.5),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppConstColor.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
            ),
            child: const Icon(
              Icons.image_not_supported,
              color: AppConstColor.primaryColor,
            ),
          );
        },
      ),
    );
  }

  /// Horizontal Category List
  Widget _buildCategoryList(HomeController controller) {
    if (controller.categories.isEmpty) {
      return const SizedBox(
        height: 90,
        child: Center(child: Text('No categories found.')),
      );
    }

    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: controller.categories.length,
        separatorBuilder: (_, __) =>
            const SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
        itemBuilder: (context, index) {
          var item = controller.categories[index];

          // These keys now store pure strings from the controller mapping step
          String categoryName = item['name'] ?? '';
          String categoryImage = item['image'] ?? '';

          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                decoration: BoxDecoration(
                  color: AppConstColor.backgroundWhite,
                  borderRadius: BorderRadius.circular(
                    Dimensions.RADIUS_OVER_EXTRA_LARGE,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: categoryImage.isNotEmpty
                    ? Image.network(
                        categoryImage,
                        height: 35,
                        width: 35,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                              Icons.restaurant,
                              size: 35,
                              color: Colors.grey,
                            ),
                      )
                    : const Icon(
                        Icons.restaurant,
                        size: 35,
                        color: Colors.grey,
                      ),
              ),
              const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              Text(
                categoryName,
                style: bodyMedium(context),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          );
        },
      ),
    );
  }

  /// Section Title Widget
  Widget _buildSectionTitle(
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
              style: TextStyle(
                color: AppConstColor.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }

  /// Food Grid
  Widget _buildFoodGrid(HomeController controller, {required bool isPopular}) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.foodItems.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: Dimensions.PADDING_SIZE_DEFAULT,
        crossAxisSpacing: Dimensions.PADDING_SIZE_DEFAULT,
        mainAxisExtent: 220,
      ),
      itemBuilder: (context, index) {
        var food = controller.foodItems[index];
        return InkWell(
          onTap: () {
            Get.toNamed(RouteName.FOOD_DETAILS_SCREEN);
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
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(Dimensions.RADIUS_LARGE),
                    ),
                    child: Image.network(
                      food['image'],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        food['name'],
                        style: bodyMedium(
                          context,
                        )?.copyWith(fontWeight: FontWeight.bold),
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
                          Text("${food['rating']}", style: caption(context)),
                          const Spacer(),
                          Text(
                            "৳${food['price']}",
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
