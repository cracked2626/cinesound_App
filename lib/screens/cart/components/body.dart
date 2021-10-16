import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Config/config.dart';
import 'package:shop_app/components/loadingWidget.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/counter_providers/cart_money.dart';
import 'package:shop_app/counter_providers/cartitemcounter.dart';
import 'package:shop_app/models/ItemModel.dart';

import '../../../size_config.dart';
import 'cart_card.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<ProductCard> productCard = [];
  List<ItemModel> models = [];
  List productId = [];
  double total_Price = 0;
  bool spin = true;
  Future<void> getCartItem() async {
    DocumentSnapshot documentSnapshot = await EcommerceApp.firestore
        .collection(EcommerceApp.collectionUser)
        .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
        .get();
    if (mounted) {
      setState(() {
        productId = documentSnapshot['userCart'];
      });
    }
    print(productId);

    for (int i = 0; i < productId.length; i++) {
      print(productId[i]);
      DocumentSnapshot documentSnapshot = await EcommerceApp.firestore
          .collection('items')
          .doc(productId[i])
          .get();
      ItemModel model = ItemModel.fromDocument(documentSnapshot);

      ProductCard p = ProductCard(
        product: model,
      );

      models.add(model);
      productCard.add(p);
      total_Price = total_Price +
          model.price -
          int.parse(model.discount) * model.price / 100;
    }

    if (mounted) {
      Provider.of<CartTotalMoney>(context, listen: false).setMoney(total_Price);
      setState(() {
        spin = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCartItem();
  }

  @override
  Widget build(BuildContext context) {
    return spin
        ? Center(
            child: circularProgress(),
          )
        : Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child:
                // StreamBuilder<DocumentSnapshot>(
                //   stream: EcommerceApp.firestore
                //       .collection(EcommerceApp.collectionUser)
                //       .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
                //       .snapshots(),
                //   builder: (context, dataSnapshot) {
                //     if (!dataSnapshot.hasData) {
                //       return Center(
                //         child: circularProgress(),
                //       );
                //     } else {
                //       print('adf');
                //       print(dataSnapshot.data.data());
                //       print(dataSnapshot.data['userCart']);
                //       List productId = dataSnapshot.data['userCart'];
                //       List<ProductCard> productCard = [];
                //       for (int i = 0; i < productId.length; i++) {
                //         DocumentSnapshot documentSnapshot = EcommerceApp.firestore
                //             .collection('items')
                //             .doc(productId[i])
                //             .get();
                //         ItemModel model = ItemModel.fromDocument(documentSnapshot);
                //         ProductCard p = ProductCard(
                //           product: model,
                //         );
                //         productCard.add(p);
                //       }
                //       return Wrap(
                //         children: productCard,
                //       );
                //     }
                //   },
                // ),
                ListView.builder(
              itemCount: models.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Dismissible(
                  key: Key(models[index].productId),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) async {
                    double price = models[index].price.toDouble();
                    price =
                        price - int.parse(models[index].discount) * price / 100;
                    setState(() {
                      total_Price = total_Price - price;
                      productCard.removeAt(index);
                      models.removeAt(index);
                      productId.removeAt(index);
                    });
                    Provider.of<CartTotalMoney>(context, listen: false)
                        .setMoney(total_Price);
                    await EcommerceApp.firestore
                        .collection(EcommerceApp.collectionUser)
                        .doc(EcommerceApp.sharedPreferences
                            .getString(EcommerceApp.userUID))
                        .update({
                      EcommerceApp.userCartList: productId,
                    });
                    EcommerceApp.sharedPreferences.setStringList(
                        EcommerceApp.userCartList, productId.cast<String>());
                    await Provider.of<CartItemCounter>(context, listen: false)
                        .displayCounter();
                    Fluttertoast.showToast(
                        msg: "Item removed from cart Successfully");
                  },
                  background: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFE6E6),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Spacer(),
                        SvgPicture.asset("assets/icons/Trash.svg"),
                      ],
                    ),
                  ),
                  child: CartCard(model: models[index]),
                ),
              ),
            ),
          );
  }
}
