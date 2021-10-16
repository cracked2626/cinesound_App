import 'package:flutter/material.dart';
import 'package:shop_app/screens/details/components/custom_app_bar.dart';
import 'package:shop_app/screens/profile/components/profile_menu.dart';

class SpeakerCategory extends StatelessWidget {
  static String routeName = "/speakerCategory";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: CustomAppBar(
        title: "Speakers",
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              ProfileMenu(
                text: "Polk Audio",
                // icon: "assets/icons/User Icon.svg",
                press: () => {},
                textStyle: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              ProfileMenu(
                text: "Jamo",
                // icon: "assets/icons/User Icon.svg",
                press: () => {},
                textStyle: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              ProfileMenu(
                text: "Jbl",
                // icon: "assets/icons/User Icon.svg",
                press: () => {},
                textStyle: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              ProfileMenu(
                text: "Onkyo",
                // icon: "assets/icons/User Icon.svg",
                press: () => {},
                textStyle: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          )),
    );
  }
}
