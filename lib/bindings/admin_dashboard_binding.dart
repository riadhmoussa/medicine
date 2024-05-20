import 'package:get/get.dart';
import 'package:medicine/controllers/about_us_controller.dart';
import 'package:medicine/controllers/admin_dashboard_controller.dart';
import 'package:medicine/controllers/change_password_controller.dart';
import 'package:medicine/controllers/dashboard_controller.dart';
import 'package:medicine/controllers/forget_password_controller.dart';
import 'package:medicine/controllers/signin_controller.dart';
import 'package:medicine/controllers/splash_controller.dart';

class AdminDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminDashboardController());
  }
}