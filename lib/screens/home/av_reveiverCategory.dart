import 'package:flutter/material.dart';
import 'package:shop_app/screens/details/components/custom_app_bar.dart';
import 'package:shop_app/screens/profile/components/profile_menu.dart';

class AvRecieverCategory extends StatelessWidget {
  static String routeName = "/categories_page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: CustomAppBar(
        title: "Av Receiver",
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              ProfileMenu(
                text: "Denon",
                // icon: "assets/icons/User Icon.svg",
                press: () => {},
                textStyle: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              ProfileMenu(
                text: "Marantz ",
                // icon: "assets/icons/User Icon.svg",
                press: () => {},
                textStyle: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              ProfileMenu(
                text: "Yamaha",
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
