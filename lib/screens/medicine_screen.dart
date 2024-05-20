import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine/routes/app_routes.dart';

import '../controllers/medicine_controller.dart';

class MedicineScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MedicineController controller = Get.put(MedicineController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des médicaments'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Recherche par référence',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
              onChanged: (value) {
                controller.searchQuery.value = value;
              },
            ),
          ),
          Expanded(
            child: Obx(
                  () {
                if (controller.filteredMedicines.isEmpty) {
                  return Center(child: Text('Aucun médicament trouvé'));
                }
                return ListView.builder(
                  itemCount: controller.filteredMedicines.length,
                  itemBuilder: (context, index) {
                    final medicine = controller.filteredMedicines[index];
                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Image.network(
                          medicine.image,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(medicine.name),
                        subtitle: Text('Référence: ${medicine.reference}\nPrix: \$${medicine.price.toStringAsFixed(2)}'),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            // Add logic to remove the medicine from the list
                            controller.removeMedicine(medicine.uid);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.addMedicine);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
