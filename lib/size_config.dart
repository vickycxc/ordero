import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double safeScreenHeight;
  static late double defaultSize;
  static late Orientation orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height * 0.82051282051;
    double topPadding = _mediaQueryData!.padding.top;
    double bottomPadding = _mediaQueryData!.padding.bottom;
    safeScreenHeight = screenHeight - topPadding - bottomPadding;
    orientation = _mediaQueryData!.orientation;
  }
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  //812 us the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

// Get the proportionate width as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  //812 us the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}