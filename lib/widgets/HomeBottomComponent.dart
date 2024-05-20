import 'package:flutter/material.dart';
import 'package:medicine/routes/app_routes.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:get/get.dart'; // Import GetX package
import '../model/Medicine.dart';
import '../utils/Common.dart';

class MLHomeBottomComponent extends StatelessWidget {
  final List<Medicine> medicines;

  MLHomeBottomComponent({super.key, required this.medicines});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text("Meilleurs médicaments", style: boldTextStyle(size: 18)),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.75,
          ),
          itemCount: medicines.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.addToCart, arguments: medicines[index]);
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 8, left: 8),
                decoration: boxDecorationRoundedWithShadow(12, backgroundColor: context.cardColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commonCachedNetworkImage(
                      (medicines[index].image),
                      height: 140,
                      width: 250,
                      fit: BoxFit.fill,
                    ).cornerRadiusWithClipRRectOnly(topLeft: 8, topRight: 8),
                    8.height,
                    Text((medicines[index].name), style: boldTextStyle()).paddingOnly(left: 8.0),
                    4.height,
                    Text((medicines[index].reference), style: secondaryTextStyle()).paddingOnly(left: 8.0),
                    4.height,
                    Text('Prix: ${medicines[index].price}').paddingOnly(left: 8.0), // Display price
                    10.height
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
