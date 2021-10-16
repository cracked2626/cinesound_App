import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData data;
  final String hintText;
  final double width;
  final TextInputType textInputType;

  CustomTextField({
    @required this.controller,
    this.data,
    @required this.hintText,
    this.width,
    this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: width == null ? MediaQuery.of(context).size.width * 0.7 : width,
      decoration: BoxDecoration(
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.shade200,
        //     offset: Offset(0.0, 5.0),
        //     blurRadius: 30.0,
        //   ),
        // ],
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      // padding: EdgeInsets.all(8.0),
      // margin: EdgeInsets.all(10.0),
      child: TextFormField(
        keyboardType:
            textInputType == null ? TextInputType.text : textInputType,
        controller: controller,
        maxLines: 1,
        style: TextStyle(fontSize: 12.0),
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: data == null
              ? null
              : Icon(
                  data,
                  color: Theme.of(context).primaryColor,
                ),
          focusColor: Theme.of(context).primaryColor,
          hintText: hintText,
        ),
      ),
    );
  }
}
