import 'package:flutter/material.dart';
import 'package:medicine/routes/app_routes.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:get/get.dart';
import '../controllers/home_fragment_controller.dart';
import '../model/Medicine.dart';
import '../utils/Common.dart';

class MLHomeBottomComponent extends StatelessWidget {
  final List<Medicine> medicines;
  final HomeFragmentController controller;
  MLHomeBottomComponent({super.key, required this.medicines, required this.controller});

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Text("Meilleurs médicaments", style: boldTextStyle(size: 18)),
        ),
        // Categories list
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: controller.categories.map((category) {
              return Obx(() {
                return GestureDetector(
                  onTap: () {
                    controller.selectedCategory.value = category;
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: controller.selectedCategory.value == category ? Colors.blue : Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        color: controller.selectedCategory.value == category ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              });
            }).toList(),
          ),
        ),
        // Search input
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Recherche par nom',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
            onChanged: (value) {
              controller.searchQuery.value = value;
            },
          ),
        ),
        // Medicines grid
        Obx(() {
          return GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.75,
            ),
            itemCount: controller.filteredMedicines.length,
            itemBuilder: (BuildContext context, int index) {
              final medicine = controller.filteredMedicines[index];
              return GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.addToCart, arguments: medicine);
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 8, left: 8),
                  decoration: boxDecorationRoundedWithShadow(12, backgroundColor: context.cardColor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      commonCachedNetworkImage(
                        medicine.image,
                        height: 140,
                        width: 250,
                        fit: BoxFit.fill,
                      ).cornerRadiusWithClipRRectOnly(topLeft: 8, topRight: 8),
                      8.height,
                      Text(medicine.name, style: boldTextStyle()).paddingOnly(left: 8.0),
                      4.height,
                      Text(medicine.reference, style: secondaryTextStyle()).paddingOnly(left: 8.0),
                      4.height,
                      Text('Prix: ${medicine.price}').paddingOnly(left: 8.0), // Display price
                      10.height,
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ],
    );
  }
}
