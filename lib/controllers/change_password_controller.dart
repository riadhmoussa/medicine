import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangePasswordController extends GetxController {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isLoading = false.obs;

  void onSubmit() async {
    final String oldPassword = oldPasswordController.text.trim();
    final String newPassword = newPasswordController.text.trim();
    final String confirmPassword = confirmPasswordController.text.trim();

    if (oldPassword.isEmpty) {
      showErrorSnackbar("Veuillez entrer votre ancien mot de passe.");
      return;
    }

    if (newPassword.isEmpty) {
      showErrorSnackbar("Veuillez entrer votre nouveau mot de passe.");
      return;
    }

    if (confirmPassword.isEmpty) {
      showErrorSnackbar("Veuillez confirmer votre nouveau mot de passe.");
      return;
    }

    if (newPassword != confirmPassword) {
      showErrorSnackbar("Les mots de passe ne correspondent pas.");
      return;
    }

    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      // Reauthenticate user
      AuthCredential credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: oldPassword,
      );
      await user.reauthenticateWithCredential(credential);

      // Update password
      await user.updatePassword(newPassword);

      // Show success message
      Get.snackbar("Succès", "Mot de passe changé avec succès.",
          backgroundColor: Colors.green);
    } catch (e) {
      // Show error message
      showErrorSnackbar("Erreur lors de la modification du mot de passe.");
      print("Error changing password: $e");
    }
  }

  void showErrorSnackbar(String message) {
    Get.snackbar("Erreur", message,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP);
  }

  @override
  void onClose() {
    super.onClose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
  }
}
