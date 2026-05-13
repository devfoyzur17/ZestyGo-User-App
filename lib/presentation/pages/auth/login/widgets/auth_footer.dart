import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../const/app_const_theme.dart';

class AuthFooter extends StatelessWidget {
  final String text;
  final String actionText;
  final VoidCallback onTap;

  const AuthFooter({
    super.key,
    required this.text,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle baseStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: AppConstColor.textBlackColor,
        );

    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Text.rich(
          TextSpan(
            text: text,
            style: baseStyle,
            children: [
              TextSpan(
                text: actionText,
                style: baseStyle.copyWith(
                  color: AppConstColor.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

