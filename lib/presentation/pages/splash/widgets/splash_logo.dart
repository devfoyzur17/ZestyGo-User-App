import 'package:flutter/material.dart';
import '../../../const/app_const_assets.dart';

class SplashLogo extends StatelessWidget {
  final double size;

  const SplashLogo({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppConstAssets.appLogoPng,
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}

