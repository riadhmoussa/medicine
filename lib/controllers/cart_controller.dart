import 'package:get/get.dart';
import 'package:medicine/model/Medicine.dart';

class CartController extends GetxController {
  var cartItems = <Medicine>[].obs;

  void addItem(Medicine item) {
    cartItems.add(item);
  }

  void removeItem(Medicine item) {
    cartItems.remove(item);
  }

  int get totalItems => cartItems.length;

  double get totalPrice => cartItems.fold(0, (sum, item) => sum + item.price);

  int getItemCount(Medicine item) {
    return cartItems.where((i) => i.uid == item.uid).length;
  }

  void clearCart() {
    cartItems.clear();
  }

}

