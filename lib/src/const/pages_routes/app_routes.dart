import 'package:get/get_navigation/get_navigation.dart';
import 'package:greengrocer/src/const/pages_routes/pages_routes.dart';
import 'package:greengrocer/src/pages/auth/screens/sign_in_screen.dart';
import 'package:greengrocer/src/pages/auth/screens/sign_up_screen.dart';
import 'package:greengrocer/src/pages/tabs/base/base_screen.dart';
import 'package:greengrocer/src/pages/splash/splash_screen.dart';
import 'package:greengrocer/src/pages/tabs/home/bindings/home_bindings.dart';

abstract class AppRoutes {
  static final pages = <GetPage>[
    GetPage(
      name: PagesRoutes.splashRoutes,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: PagesRoutes.signInRoutes,
      page: () => const SignInScreen(),
    ),
    GetPage(
      name: PagesRoutes.signUpRoutes,
      page: () => const SignUpScreen(),
    ),
    GetPage(
      name: PagesRoutes.baseRoutes,
      page: () => const BaseScreen(),
      bindings: [
        HomeBindings(),
      ],
    ),
  ];
}
