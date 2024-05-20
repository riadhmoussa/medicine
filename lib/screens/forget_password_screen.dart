import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../controllers/forget_password_controller.dart';
import '../utils/Colors.dart';
import '../utils/Common.dart';

class ForgetPasswordScreen extends StatelessWidget {
  final ForgetPasswordController controller = Get.put(ForgetPasswordController());

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
                  Text("Mot de passe oublié", style: boldTextStyle(size: 24)),
                  8.height,
                  Text("Entrez votre adresse email pour réinitialiser votre mot de passe", style: secondaryTextStyle()),
                  16.height,
                  Row(
                    children: [
                      16.width,
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
                      ).expand(),
                    ],
                  ),
                  16.height,
                  Obx(() => AppButton(
                    width: double.infinity,
                    color: mlPrimaryColor,
                    onTap: controller.isLoading.value ? null : controller.onSubmit,
                    child: controller.isLoading.value ? CircularProgressIndicator(color: white) : Text('Envoyer', style: boldTextStyle(color: white)),
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
