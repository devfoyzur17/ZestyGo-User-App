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

                  // Horizontal Category Filter
                  _buildCategoryFilter(controller),
                  const SizedBox(height: Dimensions.FREE_SIZE_EXTRA_LARGE),

                  // Popular Food Section
                  _buildSectionHeader(context, "Popular Food"),
                  _buildFoodGrid(controller),
                  const SizedBox(height: Dimensions.FREE_SIZE_EXTRA_LARGE),

                  // All Foods Section
                  _buildSectionHeader(context, "All Foods", showSeeAll: true),
                  _buildFoodGrid(controller),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Horizontal scrollable chips for category selection
  Widget _buildCategoryFilter(MenuController controller) {
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
                  controller.categories[index],
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

  /// Reusable 2-column food grid
  Widget _buildFoodGrid(MenuController controller) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 2, // Following the design pattern
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: Dimensions.PADDING_SIZE_DEFAULT,
        crossAxisSpacing: Dimensions.PADDING_SIZE_DEFAULT,
        mainAxisExtent: 230,
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
