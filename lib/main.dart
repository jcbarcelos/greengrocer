import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/const/pages_routes/pages_routes.dart';
import 'package:greengrocer/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrocer/src/const/pages_routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      key: key,
      title: 'Greengrocer',
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: const TextTheme(),
        scaffoldBackgroundColor: Colors.white.withAlpha(190),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: CustomColors.customSwatchColor,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes.pages,
      initialRoute: PagesRoutes.splashRoutes,
    );
  }
}
