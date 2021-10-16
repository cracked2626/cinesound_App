import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../size_config.dart';

class SocalCard extends StatelessWidget {
  const SocalCard({
    Key key,
    this.icon,
    this.press,
  }) : super(key: key);

  final String icon;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Material(
        borderRadius: BorderRadius.circular(24.0),
        // elevation: 1.0,
        child: Container(
          margin:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(2)),
          padding: EdgeInsets.all(getProportionateScreenWidth(6)),
          height: getProportionateScreenHeight(30),
          width: getProportionateScreenWidth(30),
          decoration: BoxDecoration(
            color: Color(0xFFF5F6F9),
            borderRadius: BorderRadius.circular(24.0),
            // shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(icon),
        ),
      ),
    );
  }
}
