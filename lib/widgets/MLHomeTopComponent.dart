import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine/routes/app_routes.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/Colors.dart';

class MLHomeTopComponent extends StatelessWidget {
  final int counter = 2;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: Get.width,
      margin: EdgeInsets.only(bottom: 16.0),
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
            ],
          ).paddingOnly(right: 16.0, left: 16.0),
        ],
      ),
    );
  }
}
