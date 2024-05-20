import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine/routes/app_routes.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileBottomComponent extends StatelessWidget {
  ProfileBottomComponent({Key? key}) : super(key: key);

  final List<String> data = <String>[
    'Paramètres',
    'Changer le mot de passe',
    'Déconnexion',
    'À propos de nous'
  ];
  final List<String> routes = <String>[
    '/settings',
    '/changePassword',
    '/logout',
    '/aboutUs'
  ];
  final List<Color> customColor = <Color>[
    Colors.blueAccent,
    Colors.orangeAccent,
    Colors.pinkAccent,
    Colors.cyan
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: boxDecorationWithRoundedCorners(
        borderRadius: radiusOnly(topRight: 32),
        backgroundColor: white,
      ),
      child: Column(
        children: [
          Column(
            children: data.asMap().entries.map((entry) {
              int index = entry.key;
              String option = entry.value;
              String route = routes[index];
              return GestureDetector(
                onTap: () async {
                  if (option == 'Déconnexion') {
                    try {
                      await FirebaseAuth.instance.signOut();
                      Get.toNamed(AppRoutes.login);
                    } catch (e) {
                      print('Error logging out: $e');
                      // Handle error logging out
                    }
                  } else {
                    Navigator.pushNamed(context, route);
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 16.0),
                  padding: EdgeInsets.all(12.0),
                  decoration: boxDecorationRoundedWithShadow(
                    8,
                    backgroundColor: context.cardColor,
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.tab, size: 24, color: Colors.blue),
                      8.width,
                      Text(
                        option.validate(),
                        style: primaryTextStyle(),
                      ).expand(),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey[300],
                        size: 16,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
