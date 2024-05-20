import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medicine/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await 3.seconds.delay();

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null ) {
        // User is logged in and email is verified
        if (user.email == 'admin@admin.com') {
          Get.offAllNamed(AppRoutes.adminDashboard);
        } else {
          Get.offAllNamed(AppRoutes.dashboard);
        }
      } else {
        // User is not logged in or email is not verified
        Get.offAllNamed(AppRoutes.login);
      }
    } catch (error) {
      print('Error: $error');
      // Handle any errors, such as Firebase initialization errors
      Get.offAllNamed(AppRoutes.login);
    }
  }
}
