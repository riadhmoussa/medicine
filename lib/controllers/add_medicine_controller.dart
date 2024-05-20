import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

class AddMedicineController extends GetxController {
  var reference = ''.obs;
  var name = ''.obs;
  var price = ''.obs;
  var imageUrl = ''.obs;

  var isValid = false.obs;

  Future<void> onSubmit() async {
    if (reference.isEmpty) {
      Get.snackbar(
        'Erreur',
        'La référence est requise.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (name.isEmpty) {
      Get.snackbar(
        'Erreur',
        'Le nom est requis.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (price.isEmpty) {
      Get.snackbar(
        'Erreur',
        'Le prix est requis.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (imageUrl.isEmpty) {
      Get.snackbar(
        'Erreur',
        'Veuillez télécharger une image.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // All fields are valid, add medicine to Firebase
    try {

      // Add medicine data to Firestore collection
      await FirebaseFirestore.instance.collection('medicines').add({
        'reference': reference.value,
        'name': name.value,
        'price': price.value,
        'imageUrl': imageUrl.value,
        'createdAt': Timestamp.now(),
      });

      // Medicine added successfully, navigate back or show success message
      Get.back();
      // Optionally, show a success snackbar
      Get.snackbar(
        'Succès',
        'Médicament ajouté avec succès.',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      print('Error adding medicine: $e');
      // Show error snackbar if adding medicine fails
      Get.snackbar(
        'Erreur',
        'Une erreur est survenue lors de l\'ajout du médicament.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }


  Future<void> uploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final File file = File(pickedFile.path);

      // Upload image to Firebase Storage
      try {
        final firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
            .ref('images/${DateTime.now().millisecondsSinceEpoch}');
        await ref.putFile(file);

        // Get the download URL
        final String downloadURL = await ref.getDownloadURL();

        // Save the image URL
        imageUrl.value = downloadURL;
      } catch (e) {
        print('Error uploading image: $e');
        Get.snackbar(
          'Erreur',
          'Une erreur est survenue lors du téléchargement de l\'image.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
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
}
