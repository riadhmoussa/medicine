import 'package:flutter/material.dart';
import '../utils/Colors.dart';
import '../utils/Common.dart';
import '../widgets/BottomNavigationBarWidget.dart';
import 'home_fragment.dart';
import 'commands_fragment.dart';
import 'profile_fragemnt.dart';

class MLDashboardScreen extends StatefulWidget {
  static String tag = '/MLDashboardScreen';

  @override
  _MLDashboardScreenState createState() => _MLDashboardScreenState();
}

class _MLDashboardScreenState extends State<MLDashboardScreen> {
  int currentWidget = 0;
  List<Widget> widgets = [
    HomeFragment(),
    CommandFragment(),
    ProfileFragment(),
  ];

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void dispose() {
    changeStatusColor(mlPrimaryColor);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: widgets[currentWidget],
        bottomNavigationBar: Container(color: Colors.white, child: showBottomDrawer()),
      ),
    );
  }

  Widget showBottomDrawer() {
    return MLBottomNavigationBarWidget(
      index: currentWidget,
      onTap: (index) {
        setState(() {});
        currentWidget = index;
      },
    );
  }
}
