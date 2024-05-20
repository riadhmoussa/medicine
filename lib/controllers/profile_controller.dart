import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileController extends GetxController {
  var fullName = ''.obs;
  var email = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCurrentUser();
  }

  Future<void> fetchCurrentUser() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception("User not found");
      }

      final userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      fullName.value = userData['fullName'];
      email.value = user.email ?? '';
    } catch (e) {
      print('Error fetching current user: $e');
    }
  }
}
