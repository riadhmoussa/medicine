import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/Medicine.dart';

class MedicineController extends GetxController {
  var medicines = <Medicine>[].obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Fetch medicines from Firestore when the controller initializes
    fetchMedicines();
  }

  Future<void> fetchMedicines() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('medicines').get();
      final List<Medicine> fetchedMedicines = snapshot.docs.map((doc) {
        final data = doc.data();
        return Medicine(
          uid: doc.id,
          image: data['imageUrl'] ?? '',
          name: data['name'] ?? '',
          reference: data['reference'] ?? '',
          category: data['category'] ?? '',
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

  List<Medicine> get filteredMedicines {
    if (searchQuery.isEmpty) {
      return medicines;
    } else {
      return medicines.where((medicine) => medicine.reference.contains(searchQuery.value)).toList();
    }
  }

  Future<void> removeMedicine(String uid) async {
    try {
      await FirebaseFirestore.instance.collection('medicines').doc(uid).delete();
      // Remove the medicine from the local list
      medicines.removeWhere((medicine) => medicine.uid == uid);
    } catch (e) {
      print('Error removing medicine: $e');
      // Handle error removing medicine
    }
  }
}
