import 'package:demo_app/presentation/const/app_const_assets.dart';
import 'package:demo_app/presentation/pages/home/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../domain/controller/dashboard_controller.dart';
import '../../const/app_const_dimensions.dart';
import '../../const/app_const_theme.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // List of screens corresponding to each tab
    final List<Widget> screens = [
      const HomeScreen(),
      const Center(child: Text("Menu Screen")),
      const Center(child: Text("Orders Screen")),
      const Center(child: Text("Profile Screen")),
    ];

    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Scaffold(
          // Display the screen based on the current index
          body: screens[controller.currentIndex],

          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: AppConstColor.backgroundWhite,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: BottomNavigationBar(
              currentIndex: controller.currentIndex,
              onTap: controller.changeIndex,
              type: BottomNavigationBarType.fixed,
              backgroundColor: AppConstColor.backgroundWhite,
              selectedItemColor: AppConstColor.primaryColor,
              unselectedItemColor: AppConstColor.hintColor,
              showUnselectedLabels: true,
              selectedLabelStyle: const TextStyle(
                fontSize: Dimensions.FONT_SIZE_SMALL,
                fontWeight: FontWeight.w500,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: Dimensions.FONT_SIZE_SMALL,
                fontWeight: FontWeight.w400,
              ),
              items: [
                _buildNavItem(
                  icon: AppConstAssets.home,
                  outlineIcon: AppConstAssets.homeOutline,
                  label: 'Home',
                  index: 0,
                  currentIndex: controller.currentIndex,
                ),
                _buildNavItem(
                  icon: AppConstAssets.menu,
                  outlineIcon: AppConstAssets.menuOutline,
                  label: 'Menu',
                  index: 1,
                  currentIndex: controller.currentIndex,
                ),
                _buildNavItem(
                  icon: AppConstAssets.order,
                  outlineIcon: AppConstAssets.orderOutline,
                  label: 'Orders',
                  index: 2,
                  currentIndex: controller.currentIndex,
                ),
                _buildNavItem(
                  icon: AppConstAssets.profileNav,
                  outlineIcon: AppConstAssets.profileNavOutline,
                  label: 'Profile',
                  index: 3,
                  currentIndex: controller.currentIndex,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Custom helper to build Navigation Items with the selection indicator line
  BottomNavigationBarItem _buildNavItem({
    required String icon,
    required String outlineIcon,
    required String label,
    required int index,
    required int currentIndex,
  }) {
    bool isSelected = index == currentIndex;

    return BottomNavigationBarItem(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top selection indicator line as seen in the design image
          Container(
            height: 3,
            width: 35,
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppConstColor.primaryColor
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
            ),
          ),
          Image.asset(isSelected ? icon : outlineIcon, height: 24),
        ],
      ),
      label: label,
    );
  }
}
