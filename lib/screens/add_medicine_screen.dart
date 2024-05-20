import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine/controllers/add_medicine_controller.dart';

class AddMedicineScreen extends StatelessWidget {
  final AddMedicineController controller = Get.put(AddMedicineController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un Médicament'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () {
                  controller.uploadImage();
                },
                child: Obx(() {
                  if (controller.imageUrl.value.isNotEmpty) {
                    // If imageUrl is not empty, display the uploaded image
                    return Container(
                      height: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(controller.imageUrl.value),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    );
                  } else {
                    // If imageUrl is empty, display the default placeholder
                    return Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          Icons.add_a_photo,
                          size: 48,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }
                }),
              ),
              SizedBox(height: 20),
              TextFormField(
                onChanged: (value) {
                  controller.reference.value = value;
                },
                decoration: InputDecoration(
                  labelText: 'Référence',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                onChanged: (value) {
                  controller.name.value = value;
                },
                decoration: InputDecoration(
                  labelText: 'Nom',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                onChanged: (value) {
                  controller.price.value = value;
                },
                decoration: InputDecoration(
                  labelText: 'Prix',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  controller.onSubmit();
                },
                child: Text('Ajouter le Médicament'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
