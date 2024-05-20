import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgetPasswordController extends GetxController {
  var emailController = TextEditingController();

  var isLoading = false.obs;

  void onSubmit() async {
    if (!GetUtils.isEmail(emailController.text)) {
      Get.snackbar(
        'Erreur',
        'Veuillez saisir une adresse e-mail valide.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    // Show loading indicator
    isLoading.value = true;

    try {
      // Send password reset email
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);

      // Password reset email sent successfully
      Get.snackbar(
        'Succès',
        'Un e-mail de réinitialisation de mot de passe a été envoyé à ${emailController.text}.',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );

      // Navigate back after success
      Get.back();
    } catch (e) {
      print('Error sending password reset email: $e');
      // Show error snackbar
      Get.snackbar(
        'Erreur',
        'Une erreur est survenue lors de l\'envoi de l\'e-mail de réinitialisation de mot de passe.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      // Hide loading indicator
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
