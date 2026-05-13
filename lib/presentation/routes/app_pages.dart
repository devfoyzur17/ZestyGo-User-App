import 'package:demo_app/presentation/pages/dashboard/dashboard_screen.dart';
import 'package:demo_app/presentation/pages/food/screen/food_details_screen.dart';

import '../pages/splash/splash_screen.dart';
import '../pages/auth/login/login_screen.dart';
import '../pages/auth/register/register_screen.dart';
import 'app_routes.dart';

abstract class RoutePages {
  static final pageBuilder = {
    RouteName.SPLASH_SCREEN: (context) => const SplashScreen(),
    RouteName.LOGIN_SCREEN: (context) => const LoginScreen(),
    RouteName.REGISTER_SCREEN: (context) => const RegisterScreen(),
    RouteName.DASHBOARD_SCREEN: (context) => const DashboardScreen(),
    RouteName.FOOD_DETAILS_SCREEN: (context) => const FoodDetailsScreen(),
  };
}
