import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine/routes/app_routes.dart';
import 'package:nb_utils/nb_utils.dart';
import '../controllers/cart_controller.dart';
import '../utils/Colors.dart';

class MLHomeTopComponent extends StatelessWidget {
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: Get.width,
      margin: EdgeInsets.only(bottom: 8.0),
      decoration: boxDecorationWithRoundedCorners(
        backgroundColor: mlColorDarkBlue,
        borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical(MediaQuery.of(context).size.width, 80.0)),
      ),
      child: Column(
        children: [
          16.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Nom du profil",
                          style: boldTextStyle(color: whiteColor)),
                      4.height,
                      Text("Bienvenue",
                          style: secondaryTextStyle(
                              color: white.withOpacity(0.7))),
                    ],
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.addToCart);
                },
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Icon(Icons.shopping_cart, color: whiteColor, size: 30),
                    Obx(() {
                      if (cartController.cartItems.isNotEmpty) {
                        return CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.red,
                          child: Text(
                            '${cartController.cartItems.length}',
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        );
                      }
                      return Container();
                    }),
                  ],
                ),
              ),
            ],
          ).paddingOnly(right: 16.0, left: 16.0),
        ],
      ),
    );
  }
}
