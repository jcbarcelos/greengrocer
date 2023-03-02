import 'package:get/get.dart';
import 'package:greengrocer/src/pages/tabs/base/controller/navigation_controller.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NavigationController());
  }
}
