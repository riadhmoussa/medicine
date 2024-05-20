import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine/controllers/admin_dashboard_controller.dart';

import 'medicine_screen.dart';
import 'admin_command_screen.dart';

class AdminDashboardScreen extends StatelessWidget {
  final AdminDashboardController dashboardController = Get.put(AdminDashboardController());

  AdminDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Dashboard')),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: SideMenu(),
          ),
          Expanded(
            flex: 4,
            child: Obx(() {
              switch (dashboardController.selectedOption.value) {
                case DashboardOption.medicines:
                  return MedicineScreen();
                case DashboardOption.commands:
                  return AdminCommandScreen();
                default:
                  return Container(); // Handle other options
              }
            }),
          ),
        ],
      ),
    );
  }
}

class SideMenu extends StatelessWidget {
  final AdminDashboardController dashboardController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Menu items
          ListTile(
            leading: Icon(Icons.medical_services),
            selected: dashboardController.selectedOption.value == DashboardOption.medicines,
            onTap: () => dashboardController.selectOption(DashboardOption.medicines),
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart), // Icon for Commands
            selected: dashboardController.selectedOption.value == DashboardOption.commands,
            onTap: () => dashboardController.selectOption(DashboardOption.commands),
          ),
          // Logout item
          ListTile(
            leading: Icon(Icons.logout),
            onTap: () {
              dashboardController.logout();
            },
          ),
        ],
      ),
    );
  }
}
