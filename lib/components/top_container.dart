import 'package:fiksii/constants.dart';
import 'package:flutter/material.dart';

class TopContainer extends StatelessWidget {
  // final double height;
  final double width;
  final Widget child;
  final EdgeInsets padding;
  TopContainer({required this.width, required this.child, required this.padding,});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(40.0),
            bottomLeft: Radius.circular(40.0),
          )),
      // height: height,
      width: width,
      child: child,
    );
  }
}
