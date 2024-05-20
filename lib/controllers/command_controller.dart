import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/command.dart';

class CommandsController extends GetxController {
  var commands = <Command>[].obs;

  @override
  void onInit() {
    fetchCommands();
    super.onInit();
  }

  void fetchCommands() async {
    try {
      String? uid = FirebaseAuth.instance.currentUser?.uid;

      if (uid == null) {
        print('Error: User UID is null');
        return;
      }

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('commands').where('uid', isEqualTo: uid).get();

      List<Command> fetchedCommands = querySnapshot.docs.map((doc) => Command.fromMap(doc.data() as Map<String, dynamic>)).toList();

      commands.assignAll(fetchedCommands);
    } catch (e) {
      print('Error fetching commands: $e');
    }
  }
}
