import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/command.dart';

class AdminCommandsController extends GetxController {
  var commands = <Command>[].obs;

  @override
  void onInit() {
    fetchCommands();
    super.onInit();
  }

  void fetchCommands() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('commands').get();

      List<Command> fetchedCommands = querySnapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return Command.fromMap(data);
      }).toList();

      commands.assignAll(fetchedCommands);
    } catch (e) {
      print('Error fetching commands: $e');
    }
  }

  void updateCommandStatus(String commandId, String newStatus) async {
    try {
      await FirebaseFirestore.instance.collection('commands').doc(commandId).update({'status': newStatus});
      fetchCommands();
    } catch (e) {
      print('Error updating command status: $e');
    }
  }
}

