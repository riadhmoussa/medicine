import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:medicine/routes/app_pages.dart';
import 'package:medicine/screens/splash_screen.dart';

import 'bindings/splash_binding.dart';
import 'controllers/cart_controller.dart';
import 'firebase_options.dart';


void main() async {
  Get.put(CartController());

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: SplashBinding(),
      home: SplashScreen(),
      getPages: AppPages.pages,
    );
  }
}
