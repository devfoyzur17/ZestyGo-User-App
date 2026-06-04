import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'core/app_localizetion_service.dart';
import 'presentation/const/app_const_theme.dart';
import 'presentation/routes/app_pages.dart';
import 'presentation/routes/app_routes.dart';
import 'package:demo_app/di_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.top],
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await di.init();

  runApp(const MyApp());
}

/// App Widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      left: false,
      right: false,
      top: false,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        title: "app_name_key".tr,
        theme: AppConstTheme.defaultTheme,
        initialRoute: RouteName.SPLASH_SCREEN,
        routes: RoutePages.pageBuilder,
        routingCallback: (route) {
          debugPrint("======>${route!.current}");
        },
      ),
    );
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class GetAppContext {
  static BuildContext? get context => navigatorKey.currentContext;
  static NavigatorState? get navigator => navigatorKey.currentState;
}
