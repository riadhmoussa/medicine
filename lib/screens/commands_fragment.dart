import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import '../controllers/command_controller.dart';
import '../model/command.dart';
import '../utils/colors.dart';

class CommandFragment extends StatelessWidget {
  static String tag = '/MLCommandFragment';

  @override
  Widget build(BuildContext context) {
    final CommandsController _commandsController = Get.put(CommandsController());

    return SafeArea(
      child: Scaffold(
        backgroundColor: mlPrimaryColor,
        body: Container(
          decoration: boxDecorationWithRoundedCorners(
            borderRadius: radiusOnly(topRight: 32),
            backgroundColor: white,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Mes commandes", style: boldTextStyle(size: 20)),
                  Obx(
                        () => _commandsController.commands.isNotEmpty
                        ? Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: boxDecorationWithRoundedCorners(
                        backgroundColor: Colors.blue.shade500,
                        boxShape: BoxShape.circle,
                      ),
                      child: Text(_commandsController.commands.length.toString(), style: primaryTextStyle(color: white)),
                    )
                        : Container(),
                  ),
                ],
              ).paddingAll(16.0),
              8.height,
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
                      return CommandCard(command: command);
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

class CommandCard extends StatelessWidget {
  final Command command;

  CommandCard({required this.command});

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
      case 'cancelled':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
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
            Text(command.medicine['name'], style: boldTextStyle(size: 18)),
            8.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Référence: ${command.medicine['reference']}', style: secondaryTextStyle()),
                Text('Quantité: ${command.quantity}', style: secondaryTextStyle()),
              ],
            ),
            8.height,
            Text('Prix: \$${command.medicine['price']}', style: secondaryTextStyle()),
            8.height,
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
          ],
        ),
      ),
    );
  }
}
