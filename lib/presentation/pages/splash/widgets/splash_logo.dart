import 'package:flutter/material.dart';
import '../../../const/app_const_assets.dart';
import '../../../const/app_const_dimensions.dart';

class SplashLogo extends StatelessWidget {
  final double size;

  const SplashLogo({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppConstAssets.appLogoPng,
          width: size,
          height: size,
          fit: BoxFit.contain,
        ),
        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        Text(
          "ZestyGo",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
