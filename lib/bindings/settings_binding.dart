import 'package:get/get.dart';
import 'package:medicine/controllers/settings_controller.dart';
import 'package:medicine/controllers/signin_controller.dart';
import 'package:medicine/controllers/splash_controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingsController());
  }
}