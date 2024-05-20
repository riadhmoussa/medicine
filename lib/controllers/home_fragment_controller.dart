import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/Medicine.dart';

class HomeFragmentController extends GetxController {
  var medicines = <Medicine>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Fetch all medicines when the controller initializes
    fetchMedicines();
  }

  Future<void> fetchMedicines() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('medicines').get();
      final List<Medicine> fetchedMedicines = snapshot.docs.map((doc) {
        final data = doc.data();
        return Medicine(
          uid: doc.id,
          image: data['imageUrl'] ?? '',
          name: data['name'] ?? '',
          reference: data['reference'] ?? '',
          price: double.tryParse(data['price'].toString()) ?? 0.0,
        );
      }).toList();

      // Update the medicines list with fetched data
      medicines.assignAll(fetchedMedicines);
    } catch (e) {
      print('Error fetching medicines: $e');
      // Handle error fetching medicines
    }
  }
}
