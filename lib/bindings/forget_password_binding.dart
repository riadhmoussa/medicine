import 'package:get/get.dart';
import 'package:medicine/controllers/forget_password_controller.dart';
import 'package:medicine/controllers/signin_controller.dart';
import 'package:medicine/controllers/splash_controller.dart';

class ForgetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgetPasswordController());
  }
}