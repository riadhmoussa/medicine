import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine/routes/app_routes.dart';
import '../model/Medicine.dart';
import 'cart_controller.dart';

class AddToCartController extends GetxController {
  final CartController cartController = Get.find<CartController>();

  var currentWidget = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void submitCommand() async {
    try {
      String? uid = FirebaseAuth.instance.currentUser?.uid;

      List<Map<String, dynamic>> cartItems = cartController.cartItems.map((item) {
        return {
          'medicine': item.toMap(),
          'quantity': cartController.getItemCount(item),
        };
      }).toList();

      await FirebaseFirestore.instance.collection('commands').add({
        'items': cartItems,
        'uid': uid,
        'timestamp': Timestamp.now(),
      });

      cartController.clearCart();

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
