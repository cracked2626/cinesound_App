import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../size_config.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({Key key, this.text, this.image, this.index})
      : super(key: key);
  final String text, image;
  final int index;

  @override
  Widget build(BuildContext context) {
    final List<RichText> richText = [
      RichText(
        text: TextSpan(
            text: "CINE",
            style: GoogleFonts.abel(
                color: Colors.black,
                letterSpacing: 3.0,
                fontSize: getProportionateScreenWidth(50),
                fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text: "SOUND",
                style: GoogleFonts.abel(
                    color: Colors.blueAccent,
                    letterSpacing: 3.0,
                    fontSize: getProportionateScreenWidth(50),
                    fontWeight: FontWeight.bold),
              ),
            ]),
      ),
      RichText(
        text: TextSpan(
          text: "BUY SPEAKERS",
          style: GoogleFonts.abel(
              color: Colors.black,
              letterSpacing: 3.0,
              fontSize: getProportionateScreenWidth(36),
              fontWeight: FontWeight.bold),
        ),
      ),
      RichText(
        text: TextSpan(
          text: "HOME THEATRE",
          style: GoogleFonts.abel(
              color: Colors.black,
              letterSpacing: 3.0,
              fontSize: getProportionateScreenWidth(36),
              fontWeight: FontWeight.bold),
        ),
      ),
    ];
    return Padding(
      padding: const EdgeInsets.only(left: 6.0, right: 6.0),
      child: Column(
        children: <Widget>[
          Spacer(),
          Spacer(),
          Spacer(),
          richText[index],
          Spacer(),
          Text(
            text,
            style: GoogleFonts.abel(letterSpacing: 2.0),
            textAlign: TextAlign.center,
          ),
          Spacer(flex: 2),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              image,
              fit: BoxFit.cover,
              height: getProportionateScreenHeight(200),
              width: getProportionateScreenWidth(300),
            ),
          ),
        ],
      ),
    );
  }
}
