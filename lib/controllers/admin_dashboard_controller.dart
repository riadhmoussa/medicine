import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:medicine/routes/app_routes.dart';

enum DashboardOption { medicines, commands }

class AdminDashboardController extends GetxController {
  var selectedOption = DashboardOption.medicines.obs;

  void selectOption(DashboardOption option) {
    selectedOption.value = option;
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      print('Error logging out: $e');
    }
  }
}
