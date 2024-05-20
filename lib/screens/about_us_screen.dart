import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('À propos de nous'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Qui sommes-nous ?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Nous sommes une équipe passionnée qui cherche à fournir les meilleurs services de santé à nos utilisateurs. Notre objectif est de rendre l\'achat de médicaments aussi simple et sûr que possible.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            Text(
              'Contactez-nous',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.email, color: Colors.blue),
                SizedBox(width: 8),
                Text(
                  'Email: contact@votrepharmacie.com',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.phone, color: Colors.blue),
                SizedBox(width: 8),
                Text(
                  'Téléphone: +1234567890',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 24),
            Text(
              'Adresse',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              '123 Rue de la Pharmacie',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Ville, Pays',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
