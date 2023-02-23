import 'package:get/get.dart';
import 'package:greengrocer/src/pages/tabs/home/controller/home_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
