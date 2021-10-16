import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/ItemModel.dart';

import '../../../size_config.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key key,
    @required this.model,
  }) : super(key: key);

  final ItemModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
          color: CupertinoColors.systemGrey6,
          borderRadius: BorderRadius.circular(15.0)),
      child: Row(
        children: [
          SizedBox(
            width: 88,
            child: AspectRatio(
              aspectRatio: 0.88,
              child: Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.network(model.thumbnailUrl[0]),
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.title}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),

                  // maxLines: 2,
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "Rs.${model.price}",
                      style: TextStyle(
                        // fontSize: 16.0,
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
                      padding: EdgeInsets.all(1.0),
                      // width: 40.0,
                      // height: 43.0,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${model.discount}% off",
                              // "50% off",
                              style: TextStyle(
                                  fontSize: 8.0,
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
                // SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        text:
                            "Rs.${model.price - int.parse(model.discount) * model.price / 100}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        // children: [
                        //   TextSpan(
                        //       text: " x${model.numOfItem}",
                        //       style: Theme.of(context).textTheme.bodyText1),
                        // ],
                      ),
                    ),
                    MaterialButton(
                      child: Text(
                        'Swipe left to Delete',
                        style: TextStyle(fontSize: 5.0),
                      ),
                      onPressed: () {},
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
