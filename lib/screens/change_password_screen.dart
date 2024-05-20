import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../controllers/change_password_controller.dart'; // Create this controller
import '../utils/Colors.dart';
import '../utils/Common.dart';

class ChangePasswordScreen extends StatelessWidget {
  final ChangePasswordController controller = Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 24.0),
            decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  80.height,
                  Text("Changer le mot de passe", style: boldTextStyle(size: 24)),
                  8.height,
                  Text("Entrez votre ancien et nouveau mot de passe", style: secondaryTextStyle()),
                  16.height,
                  AppTextField(
                    controller: controller.oldPasswordController,
                    textFieldType: TextFieldType.PASSWORD,
                    decoration: InputDecoration(
                      labelText: "Ancien Mot de passe",
                      labelStyle: secondaryTextStyle(size: 16),
                      prefixIcon: Icon(Icons.lock_outline, size: 20),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: mlColorLightGrey.withOpacity(0.2)),
                      ),
                    ),
                  ),
                  16.height,
                  AppTextField(
                    controller: controller.newPasswordController,
                    textFieldType: TextFieldType.PASSWORD,
                    decoration: InputDecoration(
                      labelText: "Nouveau Mot de passe",
                      labelStyle: secondaryTextStyle(size: 16),
                      prefixIcon: Icon(Icons.lock_outline, size: 20),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: mlColorLightGrey.withOpacity(0.2)),
                      ),
                    ),
                  ),
                  16.height,
                  AppTextField(
                    controller: controller.confirmPasswordController,
                    textFieldType: TextFieldType.PASSWORD,
                    decoration: InputDecoration(
                      labelText: "Confirmez le Mot de passe",
                      labelStyle: secondaryTextStyle(size: 16),
                      prefixIcon: Icon(Icons.lock_outline, size: 20),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: mlColorLightGrey.withOpacity(0.2)),
                      ),
                    ),
                  ),
                  16.height,
                  Obx(() => AppButton(
                    width: double.infinity,
                    color: mlPrimaryColor,
                    onTap: controller.isLoading.value ? null : controller.onSubmit,
                    child: controller.isLoading.value ? CircularProgressIndicator(color: white) : Text('Enregistrer', style: boldTextStyle(color: white)),
                  )),
                ],
              ).paddingOnly(right: 16.0, left: 16.0),
            ),
          ),
          Positioned(
            top: 30,
            child: mlBackToPrevious(context, white),
          ),
        ],
      ),
    );
  }
}
