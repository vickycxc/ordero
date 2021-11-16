import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../size_config.dart';

class CustomSuffixIcon extends StatelessWidget {
  const CustomSuffixIcon({
    Key? key, required this.svgIcon, this.color
  }) : super(key: key);

  final String svgIcon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        getProportionateScreenWidth(15),
        getProportionateScreenWidth(20),
        getProportionateScreenWidth(10),
        getProportionateScreenWidth(20),

      ),
      child: SvgPicture.asset(
        svgIcon,
        color: color,
        height: getProportionateScreenHeight(18),
      ),
    );
  }
}