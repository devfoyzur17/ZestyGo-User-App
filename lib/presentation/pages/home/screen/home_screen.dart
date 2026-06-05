import 'package:demo_app/presentation/const/app_const_assets.dart';
import 'package:demo_app/presentation/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/controller/home_controller.dart';
import '../../../../domain/controller/profile_controller.dart';
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
          // Master Loader layout conditionally handling the entire screen content
          body: controller.isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppConstColor.primaryColor,
                    ),
                  ),
                )
              : SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(
                      Dimensions.PADDING_SIZE_DEFAULT,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(context),
                        const SizedBox(
                          height: Dimensions.FREE_SIZE_EXTRA_LARGE,
                        ),
                        _buildPromoBanner(controller),
                        const SizedBox(
                          height: Dimensions.FREE_SIZE_EXTRA_LARGE,
                        ),

                        // Categories Horizontal list
                        _buildCategoryList(controller),
                        const SizedBox(
                          height: Dimensions.FREE_SIZE_OVER_EXTRA_LARGE,
                        ),

                        // Popular Foods
                        _buildSectionTitle(
                          context,
                          "Popular Foods",
                          showSeeAll: false,
                        ),
                        _buildFoodGrid(controller, isPopular: true),
                        const SizedBox(
                          height: Dimensions.FREE_SIZE_EXTRA_LARGE,
                        ),

                        // All Foods
                        _buildSectionTitle(
                          context,
                          "All Foods",
                          showSeeAll: false,
                        ),
                        _buildFoodGrid(controller, isPopular: false),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  /// User Profile Header Section Linked Dynamically with ProfileController
  Widget _buildHeader(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (profileController) {
        bool hasProfileImage = profileController.profileImage.trim().isNotEmpty;

        return Row(
          children: [
            // Dynamic Profile Image Avatar Frame
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppConstColor.dividerColor, width: 1),
              ),
              child: CircleAvatar(
                radius: 25,
                backgroundColor: AppConstColor.backgroundWhite,
                backgroundImage: hasProfileImage
                    ? NetworkImage(profileController.profileImage)
                    : null,
                child: hasProfileImage
                    ? null
                    : Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Image.asset(
                          AppConstAssets.userIcon,
                          color: AppConstColor.textBlackColor,
                        ),
                      ),
              ),
            ),
            const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

            // Dynamic Identity Texts (Name and Email Stack)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profileController.userName == "Loading..."
                        ? "Loading Name..."
                        : profileController.userName,
                    style: headline(
                      context,
                    )?.copyWith(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    profileController.userEmail,
                    style: caption(
                      context,
                    )?.copyWith(color: AppConstColor.hintColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
  /// Dynamic Promo Banner Connected with HomeController
  Widget _buildPromoBanner(HomeController controller) {
    String bannerImage = controller.promoBannerUrl.trim();

    if (bannerImage.isEmpty) {
      return Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppConstColor.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
        ),
        child: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.fastfood, color: AppConstColor.primaryColor),
              SizedBox(width: 8),
              Text(
                "Delicious Foods Await You!",
                style: TextStyle(
                  color: AppConstColor.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
      child: Image.network(
        bannerImage,
        width: double.infinity,
        height: 150,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            height: 150,
            width: double.infinity,
            color: AppConstColor.dividerColor.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(AppConstColor.primaryColor),
              ),
            ),
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
        padding: const EdgeInsets.symmetric(horizontal: 4),
        itemCount: controller.categories.length,
        separatorBuilder: (_, __) =>
            const SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
        itemBuilder: (context, index) {
          var item = controller.categories[index];

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
    List<Map<String, dynamic>> targetedList = isPopular
        ? controller.popularFoods
        : controller.allFoods;

    if (targetedList.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text("No items available here yet."),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: targetedList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: Dimensions.PADDING_SIZE_DEFAULT,
        crossAxisSpacing: Dimensions.PADDING_SIZE_DEFAULT,
        mainAxisExtent: 220,
      ),
      itemBuilder: (context, index) {
        var food = targetedList[index];
        String foodImage = food['image'] ?? '';

        return InkWell(
          onTap: () {
            Get.toNamed(
              RouteName.FOOD_DETAILS_SCREEN,
              arguments:
                  food, // Transmits the complete dynamic data map smoothly
            );
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
