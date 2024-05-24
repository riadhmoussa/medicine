import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../controllers/home_fragment_controller.dart';
import '../widgets/HomeBottomComponent.dart';
import '../widgets/MLHomeTopComponent.dart';

class HomeFragment extends StatelessWidget {
  final HomeFragmentController controller = Get.put(HomeFragmentController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            MLHomeTopComponent(),
            Obx(() {
              if (controller.medicines.isEmpty) {
                return CircularProgressIndicator();
              } else {
                return MLHomeBottomComponent(medicines: controller.medicines.toList(), controller: controller,);
              }
            }),
            64.height,
          ],
        ),
      ),
    );
  }
}
