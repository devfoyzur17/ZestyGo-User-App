import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../const/app_const_assets.dart';
import '../const/app_const_dimensions.dart';
import 'custom_svg_image.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? titleWidget;
  final Widget? leadingWidget;
  final bool isBackButtonExist;
  final Widget? menuWidget;
  final Color? backgroundColor;
  final TextStyle? titleStyle;
  final VoidCallback? onBackPress;
  final bool isBorderExist;
  final bool centerTitle;
  final bool isLeadingText;
  final Color? titleColor;
  final Color? leadingIconColor;

  const CustomAppBar({
    super.key,
    required this.title,
    this.titleWidget,
    this.leadingWidget,
    this.isBackButtonExist = true,
    this.menuWidget,
    this.backgroundColor,
    this.titleStyle,
    this.onBackPress,
    this.isBorderExist = false,
    this.centerTitle = true,
    this.isLeadingText = false,
    this.titleColor,
    this.leadingIconColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
      title:
          titleWidget ??
          Text(
            title,
            style:
                titleStyle ??
                Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                  height: 25.47 / Dimensions.FONT_SIZE_OVER_LARGE,
                  color: titleColor ?? Colors.white,
                ),
          ),
      leading: isBackButtonExist
          ? IconButton(
              icon: CustomSvgImage(
                imagePath: AppConstAssets.arrowLeftSvg,
                height: 24,
                width: 24,
                color: leadingIconColor,
              ),
              color: Theme.of(context).indicatorColor,
              onPressed: onBackPress ?? () => Get.back(),
            )
          : leadingWidget ?? const SizedBox.shrink(),
      elevation: 0,
      actions: menuWidget != null ? [menuWidget!] : null,
      centerTitle: centerTitle,
      leadingWidth: isBackButtonExist
          ? 52
          : isLeadingText
          ? 150
          : leadingWidget != null
          ? 52
          : Dimensions.PADDING_SIZE_DEFAULT + 1,
      titleSpacing: 0,

      shape: isBorderExist
          ? Border(
              bottom: BorderSide(
                color: Theme.of(context).dividerColor, // border color
                width: 1, // border thickness
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => Size(1170, GetPlatform.isDesktop ? 70 : 50);
}
