import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Config/config.dart';
import 'package:shop_app/counter_providers/cartitemcounter.dart';
import 'package:shop_app/models/ItemModel.dart';
import 'package:shop_app/size_config.dart';

import '../../../constants.dart';
import 'product_description.dart';
import 'product_images.dart';
import 'top_rounded_container.dart';

class Body extends StatefulWidget {
  final ItemModel product;

  const Body({Key key, @required this.product}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  double _scale;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {
          //
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _animationController.value;
    print(widget.product.productId);
    return ListView(
      children: [
        ProductImages(product: widget.product),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
                product: widget.product,
                pressOnSeeMore: () {},
              ),
              TopRoundedContainer(
                color: Color(0xFFF6F7F9),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(20)),
                      child: Row(
                        children: [
                          Text(
                            r"Original Price : Rs.",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          Text(
                            widget.product.price.toString(),
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(5.0),
                              color: Colors.red,
                            ),
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.all(3.0),
                            // width: 40.0,
                            // height: 43.0,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${widget.product.discount}% off",
                                    // "50% off",
                                    style: TextStyle(
                                        fontSize: 10.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  // Text(
                                  //   "OFF",
                                  //   style: TextStyle(
                                  //     fontSize: 10.0,
                                  //     color: Colors.white,
                                  //   ),
                                  // )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(20)),
                      child: Row(
                        children: [
                          Text(
                            r"New Price : ",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            r"Rs.",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            (widget.product.price -
                                    int.parse(widget.product.discount) *
                                        widget.product.price /
                                        100)
                                .toString(),
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Row(
                    //   children: [
                    //     Padding(
                    //       padding: EdgeInsets.symmetric(
                    //           horizontal: getProportionateScreenWidth(20)),
                    //       child: Text(
                    //         'Price :',
                    //         style: Theme.of(context).textTheme.headline6,
                    //       ),
                    //     ),
                    //     Text(
                    //       'Rs. ${widget.product.price.toString()}',
                    //       style: Theme.of(context).textTheme.headline6,
                    //     ),
                    //   ],
                    // ),
                    // ColorDots(product: widget.product),
                    TopRoundedContainer(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.15,
                          right: SizeConfig.screenWidth * 0.15,
                          bottom: getProportionateScreenWidth(40),
                          top: getProportionateScreenWidth(15),
                        ),
                        child: GestureDetector(
                          onTapDown: _onTapDown,
                          onTapUp: _onTapUp,
                          onTap: () {
                            checkItemInCart(widget.product.productId, context);
                          },
                          child: Transform.scale(
                            scale: _scale,
                            child: animatedButtonUi,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _onTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _animationController.reverse();
  }
}

void checkItemInCart(String productId, BuildContext context) {
  print(productId);
  EcommerceApp.sharedPreferences
          .getStringList(EcommerceApp.userCartList)
          .contains(productId)
      ? Fluttertoast.showToast(msg: 'Item is already in cart')
      : addItemToCart(productId, context);
}

addItemToCart(String productId, BuildContext context) async {
  List tempCartList =
      EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList);
  tempCartList.add(productId);
  EcommerceApp.firestore
      .collection(EcommerceApp.collectionUser)
      .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
      .update({
    EcommerceApp.userCartList: tempCartList,
  }).then((value) async {
    Fluttertoast.showToast(msg: "Item added to cart Successfully");
    EcommerceApp.sharedPreferences
        .setStringList(EcommerceApp.userCartList, tempCartList);
    await Provider.of<CartItemCounter>(context, listen: false).displayCounter();
  });
}
