import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/registration_controller.dart';
import '../utils/Colors.dart';
import '../utils/Common.dart';

class RegistrationScreen extends StatelessWidget {
  final RegistrationController controller = Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mlPrimaryColor,
        body: Stack(
          children: <Widget>[
            Positioned(
              top: 30,
              child: mlBackToPrevious(context, whiteColor),
            ),
            Container(
              margin: EdgeInsets.only(top: 250),
              padding: EdgeInsets.only(right: 16.0, left: 16.0),
              decoration: boxDecorationWithRoundedCorners(
                borderRadius: radiusOnly(topRight: 32),
                backgroundColor: context.cardColor,
              ),
              height: Get.height,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    48.height,
                    Text("Inscription", style: boldTextStyle(size: 28)),
                    8.height,
                    Text("Inscrivez-vous pour continuer", style: secondaryTextStyle(size: 16)),
                    16.height,
                    AppTextField(
                      controller: controller.fullNameController,
                      decoration: InputDecoration(
                        labelText: "Nom complet",
                        labelStyle: secondaryTextStyle(size: 16),
                        prefixIcon: Icon(Icons.person_outline, size: 20),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: mlColorLightGrey.withOpacity(0.2)),
                        ),
                      ), textFieldType: TextFieldType.NAME,
                    ),
                    16.height,
                    AppTextField(
                      controller: controller.emailController,
                      textFieldType: TextFieldType.EMAIL,
                      decoration: InputDecoration(
                        labelText: "Adresse Email",
                        labelStyle: secondaryTextStyle(size: 16),
                        prefixIcon: Icon(Icons.email_outlined, size: 20),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: mlColorLightGrey.withOpacity(0.2)),
                        ),
                      ),
                    ),
                    16.height,
                    AppTextField(
                      controller: controller.addressController,
                      decoration: InputDecoration(
                        labelText: "Adresse",
                        labelStyle: secondaryTextStyle(size: 16),
                        prefixIcon: Icon(Icons.location_on_outlined, size: 20),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: mlColorLightGrey.withOpacity(0.2)),
                        ),
                      ), textFieldType: TextFieldType.NAME,
                    ),
                    16.height,
                    AppTextField(
                      controller: controller.phoneNumberController,
                      textFieldType: TextFieldType.PHONE,
                      decoration: InputDecoration(
                        labelText: "Numéro de téléphone (Tunisie)",
                        labelStyle: secondaryTextStyle(size: 16),
                        prefixIcon: Icon(Icons.phone, size: 20),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: mlColorLightGrey.withOpacity(0.2)),
                        ),
                      ),
                    ),
                    16.height,
                    AppTextField(
                      controller: controller.passwordController,
                      textFieldType: TextFieldType.PASSWORD,
                      decoration: InputDecoration(
                        labelText: "Mot de passe",
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
                        labelText: "Confirmez le mot de passe",
                        labelStyle: secondaryTextStyle(size: 16),
                        prefixIcon: Icon(Icons.lock_outline, size: 20),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: mlColorLightGrey.withOpacity(0.2)),
                        ),
                      ),
                    ),
                    32.height,
                    Obx(() => AppButton(
                      width: double.infinity,
                      color: mlPrimaryColor,
                      onTap: controller.isLoading.value ? null : controller.onSubmit,
                      child: controller.isLoading.value ? CircularProgressIndicator(color: white) : Text("S'inscrire", style: boldTextStyle(color: white)),
                    )),
                    20.height,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
