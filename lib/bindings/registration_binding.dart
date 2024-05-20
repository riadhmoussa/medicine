import 'package:get/get.dart';
import 'package:medicine/controllers/registration_controller.dart';
import 'package:medicine/controllers/signin_controller.dart';
import 'package:medicine/controllers/splash_controller.dart';

class RegistrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegistrationController());
  }
}