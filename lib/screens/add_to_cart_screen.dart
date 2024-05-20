// AddToCartScreen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/add_to_cart_controller.dart';
import '../model/Medicine.dart';
import '../utils/Common.dart';
import '../utils/Colors.dart';

class AddToCartScreen extends StatelessWidget {
  final AddToCartController controller = Get.put(AddToCartController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mlPrimaryColor,
        body: Stack(
          children: [
            Container(
              height: Get.height,
              decoration: boxDecorationWithRoundedCorners(
                borderRadius: radiusOnly(topRight: 32),
                backgroundColor: white,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    8.height,
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          color: white,
                          size: 22,
                        ).onTap(() {
                          if (controller.currentWidget.value == 0) {
                            Navigator.of(context).pop();
                          } else {
                            controller.currentWidget.value--;
                          }
                        }),
                        Obx(() => controller.currentWidget.value == 0
                            ? Row(
                          children: [
                            Text('Panier', style: boldTextStyle(size: 24)),
                            8.width,
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: boxDecorationWithRoundedCorners(
                                backgroundColor: mlColorDarkBlue,
                                boxShape: BoxShape.circle,
                              ),
                              child: Text('3', style: secondaryTextStyle(size: 18, color: white)),
                            ),
                          ],
                        )
                            : Text('Passer à la caisse', style: boldTextStyle(size: 22))),
                      ],
                    ).paddingAll(16.0),
                    8.height,
                    Obx(() {
                      Medicine medicine = controller.selectedItem.value!;
                      return Column(
                        children: [
                          commonCachedNetworkImage(
                            medicine.image!,
                            height: 200,
                            width: Get.width,
                            fit: BoxFit.cover,
                          ),
                          16.height,
                          Text(
                            medicine.name!,
                            style: boldTextStyle(size: 18),
                          ),
                          8.height,
                          Text(
                            'Price: \$${medicine.price}',
                            style: secondaryTextStyle(),
                          ),
                          16.height,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  controller.removeFromCart();
                                },
                                icon: Icon(Icons.remove_circle_outline),
                              ),
                              8.width,
                              Obx(() => Text(
                                '${controller.quantity}',
                                style: boldTextStyle(size: 18),
                              )),
                              8.width,
                              IconButton(
                                onPressed: () {
                                  controller.addToCart();
                                },
                                icon: Icon(Icons.add_circle_outline),
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              child: Container(
                width: Get.width,
                padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0, top: 8.0),
                decoration: boxDecorationWithRoundedCorners(
                  borderRadius: radius(0.0),
                  backgroundColor: context.cardColor,
                  boxShadow: [
                    BoxShadow(color: Colors.grey, blurRadius: 0.0),
                  ],
                ),
                child: Obx(() => controller.currentWidget.value == 0
                    ? Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    8.width,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total', style: secondaryTextStyle(size: 16)),
                        Text('\$${controller.total.value}', style: boldTextStyle()),
                      ],
                    ),
                    32.width,
                    AppButton(
                      color: mlColorDarkBlue,
                      onTap: () {
                        controller.currentWidget.value++;
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Passer à la caisse', style: boldTextStyle(color: white)),
                          4.width,
                          Icon(Icons.arrow_forward_ios, color: white, size: 16),
                        ],
                      ),
                    ).expand()
                  ],
                )
                    : AppButton(
                  color: mlColorDarkBlue,
                  width: Get.width / 2,
                  onTap: () {
                    controller.submitCommand();
                  },
                  child: Text('Confirmer', style: boldTextStyle(color: white)),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
