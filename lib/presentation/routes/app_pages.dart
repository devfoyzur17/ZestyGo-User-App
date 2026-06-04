import 'package:demo_app/presentation/pages/checkout/screen/checkout_screen.dart';
import 'package:demo_app/presentation/pages/dashboard/dashboard_screen.dart';
import 'package:demo_app/presentation/pages/food/screen/food_details_screen.dart';
import 'package:demo_app/presentation/pages/order/screen/order_success_screen.dart';
import 'package:demo_app/presentation/pages/privacy/screen/privacy_policy_screen.dart';
import 'package:demo_app/presentation/pages/support/screen.dart';

import '../pages/cart/screen/cart_screen.dart';
import '../pages/order/screen/order_screen.dart';
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
    RouteName.CART_SCREEN: (context) => const CartScreen(),
    RouteName.CHECKOUT_SCREEN: (context) => const CheckoutScreen(),
    RouteName.ORDER_SUCCESS_SCREEN: (context) => const OrderSuccessScreen(),
    RouteName.ORDER_SCREEN: (context) => const OrderScreen(),
    RouteName.SUPPORT_SCREEN: (context) => const SupportScreen(),
    RouteName.PRIVACY_SCREEN: (context) => const PrivacyPolicyScreen(),
  };
}
