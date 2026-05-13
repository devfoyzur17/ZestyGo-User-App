import 'package:flutter/material.dart';
import '../../../const/app_const_assets.dart';

class SplashBackground extends StatelessWidget {
  final Size screenSize;

  const SplashBackground({super.key, required this.screenSize});

  @override
  Widget build(BuildContext context) {
    const double burgerHeight = 300;

    return Stack(
      children: [
        Positioned(
          top: -screenSize.height * 0.02,
          right: -screenSize.width * 0.02,
          child: Image.asset(
            AppConstAssets.burgerTopRight,
            height: burgerHeight,
            fit: BoxFit.contain,
          ),
        ),
        Positioned(
          left: -screenSize.width * 0.05,
          bottom: -screenSize.height * 0.02,
          child: Image.asset(
            AppConstAssets.burgerBottomLeft,
            height: burgerHeight,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
