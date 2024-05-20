import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine/routes/app_routes.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/signin_controller.dart';
import '../utils/Colors.dart';

class SignInScreen extends StatelessWidget {
  final SignInController controller = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mlPrimaryColor,
      body: Stack(
        children: [
          Positioned(
            top: 250,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: boxDecorationWithRoundedCorners(
                borderRadius: radiusOnly(topRight: 32),
                backgroundColor: context.cardColor,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    60.height,
                    Text("Bienvenue!", style: secondaryTextStyle(size: 16)),
                    16.height,
                    AppTextField(
                      controller: controller.emailController,
                      textFieldType: TextFieldType.EMAIL,
                      decoration: InputDecoration(
                        labelText: "Adresse Email",
                        labelStyle: secondaryTextStyle(size: 16),
                        prefixIcon: Icon(Icons.email_outlined, color: black),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: mlColorLightGrey.withOpacity(0.2),
                              width: 1),
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
                        prefixIcon: Icon(Icons.lock_outline, color: black),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: mlColorLightGrey.withOpacity(0.2)),
                        ),
                      ),
                    ),
                    8.height,
                    Align(
                      alignment: Alignment.topRight,
                      child: Text("Mot de passe oublié?",
                              style: secondaryTextStyle(size: 16))
                          .onTap(() {
                        Get.toNamed(AppRoutes.forgetPassword);
                      }),
                    ),
                    24.height,
                    Obx(() => AppButton(
                          color: mlPrimaryColor,
                          width: double.infinity,
                          onTap: controller.isLoading.value
                              ? null
                              : () {
                                  controller.onSubmit();
                                },
                          child: controller.isLoading.value
                              ? CircularProgressIndicator(
                                  color: white,
                                )
                              : Text("Se connecter",
                                  style: boldTextStyle(color: white)),
                        )),
                    22.height,
                    Text("Ou connectez-vous avec",
                            style: secondaryTextStyle(size: 16))
                        .center(),
                    22.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Vous n'avez pas de compte?",
                            style: primaryTextStyle()),
                        8.width,
                        Text(
                          "Inscrivez-vous",
                          style: boldTextStyle(
                              color: mlColorBlue,
                              decoration: TextDecoration.underline),
                        ).onTap(() {
                          Get.toNamed(AppRoutes.register);
                        }),
                      ],
                    ),
                    32.height,
                  ],
                ).paddingOnly(left: 16, right: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
