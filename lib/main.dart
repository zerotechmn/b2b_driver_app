import 'package:b2b_driver_app/routers/app_pages.dart';
import 'package:b2b_driver_app/routers/routers.dart';
import 'package:b2b_driver_app/services/api_service.dart';
import 'package:b2b_driver_app/services/storage_service.dart';
import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:b2b_driver_app/utils/locale.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Suppress logs in release mode
  if (!kDebugMode) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }

  initializeMongolianLocale();
  // Initialize dependencies
  await initServices();

  runApp(
    GetMaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: AppRouters.splash,
      getPages: AppPages.routes,
      builder:
          (context, child) => MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: TextScaler.noScaling),
            child: child!,
          ),
    ),
  );
}

Future<void> initServices() async {
  Get.put<StorageService>(StorageService());
  Get.put<ApiService>(ApiService());
  // Get.put<SystemMessageController>(SystemMessageController());
  // Get.put<DeepLinkService>(DeepLinkService());
}
