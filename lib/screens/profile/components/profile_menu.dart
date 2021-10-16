import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    @required this.text,
    this.icon,
    this.textStyle,
    this.press,
  });

  final String text, icon;
  final VoidCallback press;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: FlatButton(
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: kPrimaryColor,
        onPressed: press,
        child: Row(
          children: [
            icon != null
                ? SvgPicture.asset(
                    icon,
                    color: Colors.white,
                    width: 22,
                  )
                : Container(),
            SizedBox(width: 20),
            Expanded(
                child: Text(
              text,
              style: textStyle != null
                  ? textStyle
                  : TextStyle(color: Colors.white),
            )),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
