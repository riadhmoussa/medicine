import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/add_to_cart_controller.dart';
import '../model/Medicine.dart';
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
                    Obx(() {
                      // Group items by uid
                      final groupedItems = <String, Medicine>{};
                      controller.cartController.cartItems.forEach((item) {
                        if (groupedItems.containsKey(item.uid)) {
                          groupedItems[item.uid] = item;
                        } else {
                          groupedItems[item.uid] = item;
                        }
                      });

                      final uniqueItems = groupedItems.values.toList();

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: uniqueItems.length,
                        itemBuilder: (context, index) {
                          final item = uniqueItems[index];
                          return Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(color: Colors.grey.shade300),
                            ),
                            margin: EdgeInsets.all(8),
                            child: ListTile(
                              leading: Image.network(item.image,
                                  width: 50, height: 50),
                              title: Text(item.name),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Prix: ${item.price}'),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.remove_circle_outline),
                                        onPressed: () {
                                          controller.cartController
                                              .removeItem(item);
                                        },
                                      ),
                                      Text(
                                          '${controller.cartController.getItemCount(item)}'),
                                      IconButton(
                                        icon: Icon(Icons.add_circle_outline),
                                        onPressed: () {
                                          controller.cartController
                                              .addItem(item);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Obx(() {
                        return Text(
                          'Total: ${controller.cartController.totalPrice}',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              width: Get.width,
              child: Container(
                padding: EdgeInsets.only(
                    left: 16.0, right: 16.0, bottom: 8.0, top: 8.0),
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
                        Text('Total',
                            style: secondaryTextStyle(size: 16)),
                        Text('${controller.cartController.totalPrice}',
                            style: boldTextStyle()),
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
                          Text('Passer à la caisse',
                              style: boldTextStyle(color: white)),
                          4.width,
                          Icon(Icons.arrow_forward_ios,
                              color: white, size: 16),
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
                  child: Text('Confirmer',
                      style: boldTextStyle(color: white)),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
