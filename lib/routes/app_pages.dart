import 'package:get/get.dart';
import 'package:medicine/bindings/about_us_binding.dart';
import 'package:medicine/bindings/add_medicine_binding.dart';
import 'package:medicine/bindings/add_to_cart_binding.dart';
import 'package:medicine/bindings/admin_dashboard_binding.dart';
import 'package:medicine/bindings/change_password_binding.dart';
import 'package:medicine/bindings/dashboard_binding.dart';
import 'package:medicine/bindings/forget_password_binding.dart';
import 'package:medicine/bindings/registration_binding.dart';
import 'package:medicine/bindings/settings_binding.dart';
import 'package:medicine/bindings/signin_binding.dart';
import 'package:medicine/routes/app_routes.dart';
import 'package:medicine/screens/about_us_screen.dart';
import 'package:medicine/screens/add_medicine_screen.dart';
import 'package:medicine/screens/add_to_cart_screen.dart';
import 'package:medicine/screens/admin_dashboard.dart';
import 'package:medicine/screens/change_password_screen.dart';
import 'package:medicine/screens/dashboard_screen.dart';
import 'package:medicine/screens/forget_password_screen.dart';
import 'package:medicine/screens/login_screen.dart';
import 'package:medicine/screens/registration_screen.dart';
import 'package:medicine/screens/settings_screen.dart';

import '../bindings/splash_binding.dart';
import '../screens/splash_screen.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => SignInScreen(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => RegistrationScreen(),
      binding: RegistrationBinding(),
    ),
    GetPage(
      name: AppRoutes.forgetPassword,
      page: () => ForgetPasswordScreen(),
      binding: ForgetPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.dashboard,
      page: () => MLDashboardScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.changePassword,
      page: () => ChangePasswordScreen(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.aboutUs,
      page: () => AboutUsScreen(),
      binding: AboutUsBinding(),
    ),
    GetPage(
      name: AppRoutes.addToCart,
      page: () => AddToCartScreen(),
      binding: AddToCartBinding(),
    ),
    GetPage(
      name: AppRoutes.adminDashboard,
      page: () => AdminDashboardScreen(),
      binding: AdminDashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.addMedicine,
      page: () => AddMedicineScreen(),
      binding: AddMedicineBinding(),
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => SettingsScreen(),
      binding: SettingsBinding(),
    ),
  ];
}