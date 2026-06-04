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
      init: OrderController(),
      builder: (controller) {
        if (controller.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          backgroundColor: AppConstColor.backgroundGray,
          body: SafeArea(
            child:
                controller.activeOrders.isEmpty && controller.pastOrders.isEmpty
                ? _buildEmptyStateView(context)
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(
                      Dimensions.PADDING_SIZE_DEFAULT,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Page Title Header
                        Text(
                          "My Orders",
                          style: headline(context)?.copyWith(
                            fontSize: Dimensions.FONT_SIZE_OVER_EXTRA_LARGE,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: Dimensions.FREE_SIZE_EXTRA_LARGE,
                        ),

                        // Section 1: Active Order Summary Panel
                        if (controller.activeOrders.isNotEmpty) ...[
                          _buildSectionHeader(context, "Active Order Summary"),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.activeOrders.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: Dimensions.FREE_SIZE_DEFAULT,
                                ),
                            itemBuilder: (context, index) {
                              return _buildSummaryCard(
                                context,
                                controller.activeOrders[index],
                              );
                            },
                          ),
                          const SizedBox(
                            height: Dimensions.FREE_SIZE_OVER_EXTRA_LARGE,
                          ),
                        ],
                        // Section 2: Historical Order Items Stack Listing
                        if (controller.pastOrders.isNotEmpty) ...[
                          _buildSectionHeader(
                            context,
                            "Past Orders",
                            showSeeAll: controller.pastOrders.length > 5,
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.pastOrders.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: Dimensions.FREE_SIZE_DEFAULT,
                                ),
                            itemBuilder: (context, index) {
                              return _buildOrderItemCard(
                                context,
                                controller.pastOrders[index],
                              );
                            },
                          ),
                        ],
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }

  /// Fallback graphic view shown when order records collection lengths result to zero
  Widget _buildEmptyStateView(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.receipt_long_outlined,
            size: 64,
            color: AppConstColor.hintColor,
          ),
          const SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
          Text(
            "You haven't placed any orders yet.",
            style: bodyMedium(
              context,
            )?.copyWith(color: AppConstColor.hintColor),
          ),
        ],
      ),
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

  /// Dynamic Summary Card rendering tracking contexts for the active ongoing checkout operation
  Widget _buildSummaryCard(
    BuildContext context,
    Map<String, dynamic> activeOrder,
  ) {
    List items = activeOrder['items'] ?? [];
    if (items.isEmpty) return const SizedBox.shrink();

    // Fetch the primary index map data block to use as standard card thumbnail display imagery
    var primaryItem = items.first;

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
                child:
                    primaryItem['image'] != null &&
                        primaryItem['image'].toString().isNotEmpty
                    ? Image.network(
                        primaryItem['image'],
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.broken_image, size: 80),
                      )
                    : const Icon(Icons.fastfood, size: 80),
              ),
              const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            primaryItem['name'] ?? 'Food Item',
                            style: headline(
                              context,
                            )?.copyWith(fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          "৳${primaryItem['price'] ?? 0.0}",
                          style: bodyMedium(
                            context,
                          )?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      items.length > 1
                          ? "and ${items.length - 1} other delicious dynamic recipes itemized..."
                          : "Prepared to perfection.",
                      style: caption(context),
                    ),
                    const SizedBox(height: 8),
                    // Lifecycle string statuses: e.g., pending, processing, ready, cooking etc.
                    Text(
                      activeOrder['status'].toString().toUpperCase(),
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
              Text("Total ${items.length} items", style: caption(context)),
              Text(
                "৳${activeOrder['totalAmount'].toStringAsFixed(2)}",
                style: headline(context)?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Compact card item representations generating past history order blocks
  Widget _buildOrderItemCard(
    BuildContext context,
    Map<String, dynamic> pastOrder,
  ) {
    List items = pastOrder['items'] ?? [];
    String foodName = items.isNotEmpty
        ? items.first['name']
        : 'Ordered Package';
    String foodImage = items.isNotEmpty ? items.first['image'] : '';
    String currentStatus = pastOrder['status'] ?? 'delivered';

    Color statusColor = currentStatus.toString().toLowerCase() == 'delivered'
        ? AppConstColor.deliveryStatusColor
        : Colors.redAccent;

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
            child: foodImage.isNotEmpty
                ? Image.network(
                    foodImage,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.broken_image, size: 70),
                  )
                : const Icon(Icons.fastfood, size: 70),
          ),
          const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  foodName,
                  style: headline(
                    context,
                  )?.copyWith(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  "Delivery • ${pastOrder['location']}",
                  style: caption(context),
                ),
                Text(
                  "Paid via: ${pastOrder['paymentMethod'].toString().toUpperCase()} • Total: ৳${pastOrder['totalAmount']}",
                  style: caption(context),
                ),
                const SizedBox(height: 8),
                Text(
                  currentStatus,
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
