import 'package:greengrocer/src/const/endpoint.dart';

abstract class PagesRoutes {
  static const String splashRoutes = Endpoints.splashRoutes;
  static const String signInRoutes = Endpoints.signInRoutes;
  static const String signUpRoutes = Endpoints.signup;
  static const String baseRoutes = Endpoints.baseRoutes;
  static String forgetPassword = Endpoints.forgetPassword;
  static String getAllCategories = Endpoints.getAllCategories;
  static String getAllProducts = Endpoints.getAllProducts;
}
