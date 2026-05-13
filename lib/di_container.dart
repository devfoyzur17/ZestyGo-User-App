import 'dart:async';

import 'package:demo_app/domain/controller/dashboard_controller.dart';
import 'package:demo_app/domain/controller/food_details_controller.dart';
import 'package:demo_app/domain/controller/home_controller.dart';
import 'package:demo_app/domain/controller/menu_controller.dart';
import 'package:demo_app/domain/controller/order_controller.dart';
import 'package:demo_app/domain/controller/profile_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/app_localizetion_service.dart';

import 'data/services/dio/dio_client.dart';
import 'data/services/dio/logging_interceptor.dart';
import 'data/services/sharedprefarance/local_storage.dart';

Future<void> init() async {
  await dotenv.load(fileName: "assets/.env");
  final serverClientId = dotenv.env['SERVER_CLIENT_ID'];
  final baseUrl = dotenv.env['BASE_URL'];

  await Get.putAsync(() async {
    final service = AppLocalizationService();
    // This is the crucial line: wait for the files to load!
    await service.loadTranslations();
    return service;
  });

  /// Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => Dio());
  Get.lazyPut(() => LoggingInterceptor());

  /// Services

  Get.lazyPut(
    () => DioClient(
      baseUrl ?? "",
      Get.find<Dio>(),
      loggingInterceptor: Get.find<LoggingInterceptor>(),
      sharedPreferences: Get.find<SharedPreferences>(),
    ),
  );

  Get.lazyPut(() => LocalStorageServices(sharedPreferences: Get.find()));

  /// Repositories

  /// Use Cases

  /// Controllers
  Get.lazyPut(() => DashboardController(),fenix: true);
  Get.lazyPut(() => HomeController(),fenix: true);
  Get.lazyPut(() => MenuController(),fenix: true);
  Get.lazyPut(() => OrderController(),fenix: true);
  Get.lazyPut(() => ProfileController(),fenix: true);
  Get.lazyPut(() => FoodDetailsController(),fenix: true);
}
