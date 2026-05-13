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

                  // User Info Card
                  _buildProfileCard(context, controller),
                  const SizedBox(height: Dimensions.FREE_SIZE_OVER_EXTRA_LARGE),

                  // Menu Options
                  _buildMenuOption(
                    context,
                    icon: Icons.receipt_long_rounded,
                    title: "My Orders",
                    subtitle: "View past & ongoing orders",
                    onTap: () => controller.onMenuTap("Orders"),
                  ),
                  const SizedBox(height: Dimensions.FREE_SIZE_DEFAULT),
                  _buildMenuOption(
                    context,
                    icon: Icons.help_outline_rounded,
                    title: "Help & Support",
                    subtitle: "Contact us.",
                    onTap: () => controller.onMenuTap("Support"),
                  ),
                  const SizedBox(height: Dimensions.FREE_SIZE_DEFAULT),
                  _buildMenuOption(
                    context,
                    icon: Icons.shield_outlined,
                    title: "Privacy Policy",
                    subtitle: "policy details",
                    onTap: () => controller.onMenuTap("Privacy"),
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
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10)],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Profile Image
              const CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage('https://img.freepik.com/free-photo/young-man-wearing-suit_23-2149303643.jpg'),
              ),
              const SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),

              // Name
              Expanded(
                child: Text(
                  controller.userName,
                  style: headline(context)?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),

              // Edit Button
              GestureDetector(
                onTap: controller.onEditProfile,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppConstColor.primaryColor,
                    borderRadius: BorderRadius.circular(Dimensions.RADIUS_OVER_EXTRA_LARGE),
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
            padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT),
            child: Divider(color: AppConstColor.dividerColor),
          ),

          // Orders Statistics Box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
            decoration: BoxDecoration(
              border: Border.all(color: AppConstColor.primaryColor, width: 1),
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
            ),
            child: Column(
              children: [
                Text(
                  "${controller.totalOrders}",
                  style: headline(context)?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
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
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10)],
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
        title: Text(title, style: headline(context)?.copyWith(fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text(subtitle, style: caption(context)),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: AppConstColor.hintColor),
      ),
    );
  }
}