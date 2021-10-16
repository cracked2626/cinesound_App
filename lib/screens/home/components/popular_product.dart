import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/components/loadingWidget.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/ItemModel.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class PopularProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(title: "Popular Products", press: () {}),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("items")
              .orderBy("publishedDate", descending: true)
              .snapshots(),
          builder: (context, dataSnapshot) {
            if (!dataSnapshot.hasData) {
              return Center(
                child: circularProgress(),
              );
            } else {
              List<ProductCard> productCard = [];
              for (int i = 0; i < dataSnapshot.data.docs.length; i++) {
                ItemModel model =
                    ItemModel.fromDocument(dataSnapshot.data.docs[i]);
                print('a');
                print(dataSnapshot.data.docs[i].id);
                ProductCard p = ProductCard(
                  product: model,
                );
                productCard.add(p);
              }
              return Wrap(
                children: productCard,
              );
            }
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...List.generate(
                    dataSnapshot.data.docs.length,
                    (index) {
                      ItemModel model =
                          ItemModel.fromDocument(dataSnapshot.data.docs[index]);
                      return ProductCard(product: model);

                      return SizedBox
                          .shrink(); // here by default width and height is 0
                    },
                  ),
                  SizedBox(width: getProportionateScreenWidth(20)),
                ],
              ),
            );
          },
        ),
        // SingleChildScrollView(
        //   scrollDirection: Axis.horizontal,
        //   child: Row(
        //     children: [
        //       ...List.generate(
        //         demoProducts.length,
        //         (index) {
        //           if (demoProducts[index].isPopular)
        //             return ProductCard(product: demoProducts[index]);
        //
        //           return SizedBox
        //               .shrink(); // here by default width and height is 0
        //         },
        //       ),
        //       SizedBox(width: getProportionateScreenWidth(20)),
        //     ],
        //   ),
        // )
      ],
    );
  }
}
