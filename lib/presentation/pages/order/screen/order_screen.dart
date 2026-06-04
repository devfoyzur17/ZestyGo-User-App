import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/controller/order_controller.dart';
import '../../../const/app_const_dimensions.dart';
import '../../../const/app_const_theme.dart';
import '../../../const/styles.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
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
                    "My Orders",
                    style: headline(context)?.copyWith(
                      fontSize: Dimensions.FONT_SIZE_OVER_EXTRA_LARGE,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: Dimensions.FREE_SIZE_EXTRA_LARGE),

                  // Section 1: Order Summary
                  _buildSectionHeader(context, "Order Summary"),
                  _buildSummaryCard(context),
                  const SizedBox(height: Dimensions.FREE_SIZE_OVER_EXTRA_LARGE),

                  // Section 2: Ordered Items
                  _buildSectionHeader(
                    context,
                    "Ordered Items",
                    showSeeAll: true,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.orderedItems.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: Dimensions.FREE_SIZE_DEFAULT),
                    itemBuilder: (context, index) {
                      return _buildOrderItemCard(
                        context,
                        controller.orderedItems[index],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Reusable Section Header with optional "See All"
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
          Text(
            title,
            style: headline(context)?.copyWith(fontWeight: FontWeight.bold),
          ),
          if (showSeeAll)
            Text(
              "See All",
              style: bodyMedium(
                context,
              )?.copyWith(color: AppConstColor.hintColor),
            ),
        ],
      ),
    );
  }

  /// Detailed Summary Card for the latest/active order
  Widget _buildSummaryCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      decoration: BoxDecoration(
        color: AppConstColor.cardColor,
        borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                child: Image.network(
                  'https://img.freepik.com/free-photo/delicious-burger-with-fresh-ingredients_23-2150857908.jpg',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Veggi Burger",
                          style: headline(
                            context,
                          )?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "৳10.00",
                          style: bodyMedium(
                            context,
                          )?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "smoky barbecue sauce & caramelized onions",
                      style: caption(context),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Ready",
                      style: bodyMedium(context)?.copyWith(
                        color: AppConstColor.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: Dimensions.PADDING_SIZE_DEFAULT,
            ),
            child: Divider(color: AppConstColor.dividerColor, thickness: 1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total 4 items", style: caption(context)),
              Text(
                "৳40.00",
                style: headline(context)?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Compact card for historical/other ordered items
  Widget _buildOrderItemCard(BuildContext context, Map<String, dynamic> item) {
    // Determine status color based on design
    Color statusColor = item['status'] == 'Delivered'
        ? AppConstColor.deliveryStatusColor
        : AppConstColor.primaryColor;

    return Container(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      decoration: BoxDecoration(
        color: AppConstColor.cardColor,
        borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
            child: Image.network(
              item['image'],
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'],
                  style: headline(
                    context,
                  )?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text("Delivery • ${item['location']}", style: caption(context)),
                Text("From ${item['shop']}", style: caption(context)),
                const SizedBox(height: 8),
                Text(
                  item['status'],
                  style: bodyMedium(
                    context,
                  )?.copyWith(color: statusColor, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
