import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class SettingsController extends GetxController {
  var fullNameController = TextEditingController();
  var addressController = TextEditingController();
  var phoneNumberController = TextEditingController();

  var isLoading = false.obs;
  var userImage = Rxn<String>("");

  @override
  void onInit() {
    super.onInit();
    fetchUserInfo();
  }

  void fetchUserInfo() async {
    try {
      isLoading(true);
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        showErrorSnackbar("Utilisateur non trouvé. Veuillez vous reconnecter.");
        return;
      }

      final userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (userData.exists) {
        fullNameController.text = userData['fullName'] ?? '';
        addressController.text = userData['address'] ?? '';
        phoneNumberController.text = userData['phoneNumber'] ?? '';
      }
      isLoading(false);
    } catch (e) {
      isLoading(false);
      showErrorSnackbar("Une erreur s'est produite lors de la récupération des informations utilisateur.");
      print('Error fetching user info: $e');
    }
  }

  void updateUserDetails() async {
    final fullName = fullNameController.text.trim();
    final address = addressController.text.trim();
    final phoneNumber = phoneNumberController.text.trim();

    if (fullName.isEmpty || address.isEmpty || phoneNumber.isEmpty) {
      showErrorSnackbar("Veuillez remplir tous les champs.");
      return;
    }

    try {
      isLoading(true);

      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        showErrorSnackbar("Utilisateur non trouvé. Veuillez vous reconnecter.");
        return;
      }

      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'fullName': fullName,
        'address': address,
        'phoneNumber': phoneNumber,
      });

      isLoading(false);

      Get.snackbar(
        "Succès",
        "Détails utilisateur mis à jour avec succès.",
        backgroundColor: Colors.green,
      );
    } catch (e) {
      isLoading(false);
      showErrorSnackbar("Une erreur s'est produite. Veuillez réessayer plus tard.");
      print('Error updating user details: $e');
    }
  }

  void pickImageFromGallery() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      try {
        isLoading(true);

        // Upload image to Firebase Storage
        final File imageFile = File(pickedImage.path);
        final user = FirebaseAuth.instance.currentUser;
        final imageRef = FirebaseStorage.instance.ref().child('user_images/${user?.uid}/${DateTime.now()}.jpg');
        final uploadTask = imageRef.putFile(imageFile);
        final TaskSnapshot uploadSnapshot = await uploadTask.whenComplete(() {});
        final imageUrl = await uploadSnapshot.ref.getDownloadURL();

        // Update user image URL in Firestore
        await FirebaseFirestore.instance.collection('users').doc(user?.uid).update({
          'imageUrl': imageUrl,
        });

        isLoading(false);
        Get.snackbar(
          'Succès',
          'Image téléchargée avec succès.',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } catch (e) {
        isLoading(false);
        Get.snackbar(
          'Erreur',
          'Une erreur s\'est produite lors du téléchargement de l\'image. Veuillez réessayer plus tard.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        print('Error uploading image: $e');
      }
    } else {
      Get.snackbar(
        'Erreur',
        'Aucune image sélectionnée.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void setUserImage(String image) {
    userImage.value = image;
  }

  void showErrorSnackbar(String message) {
    Get.snackbar(
      "Erreur",
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
    );
  }

  @override
  void onClose() {
    super.onClose();
    fullNameController.dispose();
    addressController.dispose();
    phoneNumberController.dispose();
  }
}
