import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';

import '../../../size_config.dart';
import 'home_header.dart';
import 'popular_product.dart';
import 'special_offers.dart';

class Body extends StatefulWidget {
  final Function whenPageChanges;
  Body({@required this.whenPageChanges});
  @override
  _BodyState createState() => _BodyState(whenPageChanges: whenPageChanges);
}

class _BodyState extends State<Body> {
  Function whenPageChanges;
  _BodyState({@required this.whenPageChanges});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          scrollDirection: Axis.horizontal,
          controller: controller,
          onPageChanged: whenPageChanges,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: getProportionateScreenHeight(20)),
                  HomeHeader(),
                  SizedBox(height: getProportionateScreenWidth(10)),
                  // DiscountBanner(),
                  // Categories(),
                  SpecialOffers(),
                  SizedBox(height: getProportionateScreenWidth(30)),
                  PopularProducts(),
                  SizedBox(height: getProportionateScreenWidth(30)),
                ],
              ),
            ),
            CartScreen(),
            Container(
              child: Center(child: Text("Lohia")),
            ),
            ProfileScreen(),
          ],
        ),
      ),
    );
  }
}
