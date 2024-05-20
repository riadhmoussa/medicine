import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../controllers/profile_controller.dart';
import '../widgets/MLProfileBottomComponent.dart';

class ProfileFragment extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: 225,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: Colors.blue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() => Text(profileController.fullName.value, style: TextStyle(color: Colors.white, fontSize: 24))),
                      4.height,
                      Obx(() => Text(profileController.email.value, style: TextStyle(color: Colors.white, fontSize: 16))),
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  if (index == 0) {
                    return ProfileBottomComponent();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
