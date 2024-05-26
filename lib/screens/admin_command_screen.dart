import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medicine/controllers/admin_commands_controller.dart';
import 'package:nb_utils/nb_utils.dart';
import '../model/command.dart';
import '../utils/colors.dart';

class AdminCommandScreen extends StatelessWidget {
  const AdminCommandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AdminCommandsController _commandsController = Get.put(AdminCommandsController());

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: boxDecorationWithRoundedCorners(
            borderRadius: radiusOnly(topRight: 32),
            backgroundColor: white,
          ),
          child: Column(
            children: [
              Expanded(
                child: Obx(
                      () => _commandsController.commands.isEmpty
                      ? Center(
                    child: CircularProgressIndicator(),
                  )
                      : ListView.builder(
                    itemCount: _commandsController.commands.length,
                    itemBuilder: (context, index) {
                      Command command = _commandsController.commands[index];
                      return AdminCommandCard(command: command, controller: _commandsController);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AdminCommandCard extends StatelessWidget {
  final Command command;
  final AdminCommandsController controller;

  AdminCommandCard({required this.command, required this.controller});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (command.status) {
      case 'encours':
        statusColor = Colors.orange;
        break;
      case 'completed':
        statusColor = Colors.green;
        break;
      case 'annuler':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }

    // Create a map to store the count of each medicine
    Map<String, int> medicineCount = {};

    // Count the occurrence of each medicine
    for (var item in command.medicines) {
      String medicineName = item['medicine']['name'] as String;
      medicineCount[medicineName] = (medicineCount[medicineName] ?? 0) + 1;
    }

    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var entry in medicineCount.entries) ...[
              Text('Name: ${entry.key}', style: boldTextStyle(size: 18)),
              8.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Quantity: ${entry.value}', style: secondaryTextStyle()),
                ],
              ),
              8.height,
            ],
            Text('Date: ${DateFormat('yyyy-MM-dd – kk:mm').format(command.timestamp.toDate())}', style: secondaryTextStyle()),
            8.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Statut:', style: secondaryTextStyle()),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(command.status, style: boldTextStyle(color: white)),
                ),
              ],
            ),
            8.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => controller.updateCommandStatus(command.id, 'completed'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: Text('Compléter'),
                ),
                ElevatedButton(
                  onPressed: () => controller.updateCommandStatus(command.id, 'annuler'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: Text('Annuler'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
