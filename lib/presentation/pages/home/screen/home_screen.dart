import 'package:demo_app/presentation/const/app_const_assets.dart';
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
                  _buildCategoryList(controller),
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

  /// Orange Gradient Promo Banner
  Widget _buildPromoBanner() {
    return Container(
      width: double.infinity,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
        gradient: const LinearGradient(
          colors: [AppConstColor.primaryColor, AppConstColor.splashYellow],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "30% OFF",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppConstColor.textWhiteColor,
                  ),
                ),
                Text(
                  "On all burger sets",
                  style: TextStyle(
                    fontSize: Dimensions.FONT_SIZE_LARGE,
                    color: AppConstColor.textWhiteColor,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: -10,
            top: 0,
            bottom: 0,
            child: Image.network(
              'https://img.freepik.com/free-photo/double-hamburger-isolated-white-background-fresh-burger-fast-food-with-beef-cheese_90220-1092.jpg',
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  /// Horizontal Category List
  Widget _buildCategoryList(HomeController controller) {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: controller.categories.length,
        separatorBuilder: (_, __) =>
            const SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
        itemBuilder: (context, index) {
          var item = controller.categories[index];
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
                child: Image.network(item['image']!, height: 35, width: 35),
              ),
              const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              Text(item['name']!, style: bodyMedium(context)),
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

  /// Responsive Food Grid
  Widget _buildFoodGrid(HomeController controller, {required bool isPopular}) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 2, // Fixed for demo based on image
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: Dimensions.PADDING_SIZE_DEFAULT,
        crossAxisSpacing: Dimensions.PADDING_SIZE_DEFAULT,
        mainAxisExtent: 220, // Manual height for responsiveness
      ),
      itemBuilder: (context, index) {
        var food = controller.foodItems[index];
        return Container(
          decoration: BoxDecoration(
            color: AppConstColor.cardColor,
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
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
        );
      },
    );
  }
}
