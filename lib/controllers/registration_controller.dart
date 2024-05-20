import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine/routes/app_routes.dart';

class RegistrationController extends GetxController {
  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var addressController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  var isLoading = false.obs;

  Future<void> onSubmit() async {
    if (fullNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        addressController.text.isEmpty ||
        phoneNumberController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      Get.snackbar(
        'Erreur',
        'Veuillez remplir tous les champs',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (!emailController.text.contains('@')) {
      Get.snackbar(
        'Erreur',
        'Veuillez entrer une adresse email valide',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (!RegExp(r'^(\+216|00216)?[2459]\d{7}$')
        .hasMatch(phoneNumberController.text)) {
      Get.snackbar(
        'Erreur',
        'Veuillez entrer un numéro de téléphone tunisien valide',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar(
        'Erreur',
        'Les mots de passe ne correspondent pas',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;

      // Create user with email and password
      final UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Add user data to Firestore collection 'users'
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'fullName': fullNameController.text,
        'email': emailController.text,
        'address': addressController.text,
        'phoneNumber': phoneNumberController.text,
      });

      isLoading.value = false;

      // Navigate to the dashboard after successful registration
      Get.offNamed(AppRoutes.dashboard);
    } catch (e) {
      isLoading.value = false;
      print('Error registering user: $e');
      Get.snackbar(
        'Erreur',
        'Une erreur est survenue lors de l\'inscription. Veuillez réessayer.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
