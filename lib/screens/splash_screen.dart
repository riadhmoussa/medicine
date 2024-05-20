import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Initialize the SplashController
    final SplashController controller = Get.put(SplashController());

    return Scaffold(
      body: Center(
        child: Image.asset("assets/logo_med.png",
            height: 150, width: 150, fit: BoxFit.fill),
      ),
    );
  }
}
