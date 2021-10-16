import 'package:flutter/material.dart';
import 'package:shop_app/models/ItemModel.dart';

import '../../../size_config.dart';
import 'custom_app_bar.dart';

class ShowProductDiscription extends StatelessWidget {
  static String routeName = "/showMoreDetails";
  ShowProductDiscription({
    @required this.product,
  });

  final ItemModel product;
  @override
  Widget build(BuildContext context) {
    print(product.title);
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: CustomAppBar(rating: 0.0),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: Text(
                product.shortInfo,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 20.0,
                left: getProportionateScreenWidth(20),
                right: getProportionateScreenWidth(64),
              ),
              child: Text(
                product.longDescription,
                maxLines: null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
