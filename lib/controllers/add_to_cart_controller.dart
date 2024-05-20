import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine/routes/app_routes.dart';
import '../model/Medicine.dart';

class AddToCartController extends GetxController {
  var currentWidget = 0.obs;
  var total = 0.0.obs;

  var selectedItem = Rx<Medicine?>(null);
  var quantity = 1.obs;

  @override
  void onInit() {
    selectedItem.value = Get.arguments as Medicine?;
    total.value = selectedItem.value?.price ?? 0;
    super.onInit();
  }

  void addToCart() {
    quantity.value = (quantity.value ?? 1) + 1;
    total.value = (total.value ?? 0) + (selectedItem.value!.price ?? 0);
  }

  void removeFromCart() {
    quantity.value = (quantity.value ?? 1) - 1;
    if (quantity.value! < 1) {
      quantity.value = 1;
    }
    total.value = (total.value ?? 0) - (selectedItem.value!.price ?? 0);
  }

  void submitCommand() async {
    try {
      String? uid = FirebaseAuth.instance.currentUser?.uid;

      await FirebaseFirestore.instance.collection('commands').add({
        'medicine': selectedItem.value!.toMap(),
        'quantity': quantity.value,
        'uid': uid,
        'timestamp': Timestamp.now(),
      });

      selectedItem.value = null;
      quantity.value = 1;

      // Show success message
      Get.snackbar('Success', 'Command submitted successfully');

      // Navigate to dashboard
      Get.offNamed(AppRoutes.dashboard);
    } catch (e) {
      print('Error submitting command: $e');
      // Handle error if necessary
      Get.snackbar('Error', 'Failed to submit command');
    }
  }

}
