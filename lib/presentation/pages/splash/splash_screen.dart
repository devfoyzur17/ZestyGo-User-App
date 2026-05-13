import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../const/app_const_theme.dart';
import '../../routes/app_routes.dart';
import 'widgets/splash_background.dart';
import 'widgets/splash_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Get.offNamed(RouteName.LOGIN_SCREEN);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);
    final double logoSize = screenSize.width * 0.28;

    return Scaffold(
      backgroundColor: AppConstColor.splashYellow,
      body: Stack(
        alignment: Alignment.center,
        children: [
          SplashBackground(screenSize: screenSize),
          SplashLogo(size: logoSize),
        ],
      ),
    );
  }
}
