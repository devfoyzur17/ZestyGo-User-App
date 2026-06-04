import 'package:demo_app/presentation/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/controller/profile_controller.dart';
import '../../../const/app_const_dimensions.dart';
import '../../../const/app_const_theme.dart';
import '../../../const/styles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) {
        // Show indicator overlay while fetching data states from remote networks
        if (controller.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

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
                    "Profile",
                    style: headline(context)?.copyWith(
                      fontSize: Dimensions.FONT_SIZE_OVER_EXTRA_LARGE,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: Dimensions.FREE_SIZE_EXTRA_LARGE),

                  // Dynamic User Info Card Module
                  _buildProfileCard(context, controller),
                  const SizedBox(height: Dimensions.FREE_SIZE_OVER_EXTRA_LARGE),

                  // Menu Options Link Items
                  _buildMenuOption(
                    context,
                    icon: Icons.receipt_long_rounded,
                    title: "My Orders",
                    subtitle: "View past & ongoing orders",
                    onTap: () => Get.toNamed(RouteName.ORDER_SCREEN),
                  ),
                  const SizedBox(height: Dimensions.FREE_SIZE_DEFAULT),
                  _buildMenuOption(
                    context,
                    icon: Icons.help_outline_rounded,
                    title: "Help & Support",
                    subtitle: "Contact us.",
                    onTap: () => Get.toNamed(RouteName.SUPPORT_SCREEN),
                  ),
                  const SizedBox(height: Dimensions.FREE_SIZE_DEFAULT),
                  _buildMenuOption(
                    context,
                    icon: Icons.shield_outlined,
                    title: "Privacy Policy",
                    subtitle: "policy details",
                    onTap: () => Get.toNamed(RouteName.PRIVACY_SCREEN),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// The main card containing user details and order stats
  Widget _buildProfileCard(BuildContext context, ProfileController controller) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      decoration: BoxDecoration(
        color: AppConstColor.cardColor,
        borderRadius: BorderRadius.circular(Dimensions.RADIUS_OVER_EXTRA_LARGE),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Dynamic Profile Image Handler with a default Professional Man Avatar Placeholder
              CircleAvatar(
                radius: 35,
                backgroundColor: AppConstColor.backgroundGray,
                backgroundImage: controller.profileImage.isNotEmpty
                    ? NetworkImage(controller.profileImage)
                    : const NetworkImage(
                        'https://cdn-icons-png.flaticon.com/512/3135/3135715.png', // Clear illustration vector of a man profile
                      ),
              ),
              const SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),

              // Dynamic Name & Email Display Stack Tracker
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.userName,
                      style: headline(
                        context,
                      )?.copyWith(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      controller.userEmail,
                      style: caption(
                        context,
                      )?.copyWith(color: AppConstColor.hintColor),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // Edit Action Trigger Button
              GestureDetector(
                onTap: controller.onEditProfile,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppConstColor.primaryColor,
                    borderRadius: BorderRadius.circular(
                      Dimensions.RADIUS_OVER_EXTRA_LARGE,
                    ),
                  ),
                  child: Text(
                    "Edit",
                    style: bodyMedium(context)?.copyWith(
                      color: AppConstColor.textWhiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: Dimensions.PADDING_SIZE_DEFAULT,
            ),
            child: Divider(color: AppConstColor.dividerColor),
          ),

          // Orders Statistics Box - Now live mapping from Firestore aggregates
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: Dimensions.PADDING_SIZE_SMALL,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: AppConstColor.primaryColor, width: 1),
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
            ),
            child: Column(
              children: [
                Text(
                  "${controller.totalOrders}",
                  style: headline(
                    context,
                  )?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text("Orders", style: caption(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Reusable widget for profile list items
  Widget _buildMenuOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppConstColor.cardColor,
        borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_SMALL,
          vertical: 4,
        ),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppConstColor.primaryColor,
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
          ),
          child: Icon(icon, color: AppConstColor.textWhiteColor, size: 20),
        ),
        title: Text(
          title,
          style: headline(
            context,
          )?.copyWith(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: Text(subtitle, style: caption(context)),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 16,
          color: AppConstColor.hintColor,
        ),
      ),
    );
  }
}
