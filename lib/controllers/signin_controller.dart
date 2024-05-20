import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medicine/routes/app_routes.dart';

class SignInController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isLoading = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> onSubmit() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || !GetUtils.isEmail(email)) {
      Get.snackbar(
        'Erreur',
        'Veuillez entrer une adresse email valide.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (password.isEmpty || password.length < 6) {
      Get.snackbar(
        'Erreur',
        'Le mot de passe doit contenir au moins 6 caractères.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      isLoading.value = false;

      // Check if the signed-in user is an admin
      if (email == 'admin@admin.com') {
        Get.offNamed(AppRoutes.adminDashboard);
      } else {
        Get.offNamed(AppRoutes.dashboard);
      }
    } catch (error) {
      isLoading.value = false;
      Get.snackbar(
        'Erreur',
        'Échec de la connexion. Veuillez réessayer.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
