import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key, required this.text, required this.press, this.color = kPrimaryColor,
  }) : super(key: key);
  final String text;
  final VoidCallback press;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return
    //   SizedBox(
    //   height: getProportionateScreenHeight(56),
    //   width: double.infinity,
    //   child: TextButton(
    //       style: TextButton.styleFrom(backgroundColor: kPrimaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
    //       onPressed: press,
    //       child: Text(
    //         text,
    //         style: TextStyle(
    //             fontSize: getProportionateScreenWidth(18),
    //             color: Colors.white),
    //       )),
    // );
    SizedBox(
      height: getProportionateScreenHeight(56),
      width: double.infinity,
      child: TextButton(
          style: TextButton.styleFrom(backgroundColor: color, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(
                fontSize: getProportionateScreenWidth(18),
                color: Colors.white),
          )),
    );
  }
}
