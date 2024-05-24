import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine/routes/app_routes.dart';

import '../model/Medicine.dart';

class AddEditMedicineController extends GetxController {
  final referenceController = TextEditingController();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  var imageUrl = ''.obs;

  var isEditMode = false.obs;
  final medicine = Rxn<Medicine>();

  // List of categories
  final categories = ['Antibiotic', 'Analgesic', 'Antiseptic', 'Antipyretic', 'Vaccine'].obs;
  var selectedCategory = ''.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      medicine.value = Get.arguments as Medicine;
      referenceController.text = medicine.value?.reference ?? '';
      nameController.text = medicine.value?.name ?? '';
      priceController.text = medicine.value?.price.toString() ?? '';
      imageUrl.value = medicine.value?.image ?? '';
      selectedCategory.value = medicine.value?.category ?? categories.first;
      isEditMode.value = true;
    } else {
      selectedCategory.value = categories.first;
    }
  }

  @override
  void onClose() {
    referenceController.dispose();
    nameController.dispose();
    priceController.dispose();
    super.onClose();
  }

  Future<void> onSubmit() async {
    if (referenceController.text.isEmpty) {
      Get.snackbar(
        'Erreur',
        'La référence est requise.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (nameController.text.isEmpty) {
      Get.snackbar(
        'Erreur',
        'Le nom est requis.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (priceController.text.isEmpty) {
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

    try {
      if (isEditMode.value) {
        // Update existing medicine
        await FirebaseFirestore.instance
            .collection('medicines')
            .doc(medicine.value?.uid)
            .update({
          'reference': referenceController.text,
          'name': nameController.text,
          'price': double.tryParse(priceController.text) ?? 0.0,
          'imageUrl': imageUrl.value,
          'category': selectedCategory.value,
          'updatedAt': Timestamp.now(),
        });

        Get.snackbar(
          'Succès',
          'Médicament mis à jour avec succès.',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 2), // Set duration for the snackbar
        );
      } else {
        // Add new medicine
        await FirebaseFirestore.instance.collection('medicines').add({
          'reference': referenceController.text,
          'name': nameController.text,
          'price': double.tryParse(priceController.text) ?? 0.0,
          'imageUrl': imageUrl.value,
          'category': selectedCategory.value,
          'createdAt': Timestamp.now(),
        });

        Get.snackbar(
          'Succès',
          'Médicament ajouté avec succès.',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 2), // Set duration for the snackbar
        );
      }

      print('Navigating back...');
      Get.offNamed(AppRoutes.adminDashboard);
      // Alternative navigation
      // // Use this if you have named routes

    } catch (e) {
      print('Error adding/updating medicine: $e');
      Get.snackbar(
        'Erreur',
        'Une erreur est survenue lors de l\'ajout/mise à jour du médicament.',
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

      try {
        final firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
            .ref('images/${DateTime.now().millisecondsSinceEpoch}');
        await ref.putFile(file);

        final String downloadURL = await ref.getDownloadURL();
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
