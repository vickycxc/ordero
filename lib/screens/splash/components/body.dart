import 'package:fiksii/screens/sign_in/sign_in_screen.dart';
import 'package:fiksii/screens/splash/components/splash_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;

  List<Map<String, String>> splashData = [
    {
      "title": "Manage,\norganize,\ndeliver your\nproducts, easily",
      "subtitle": "Ordero is the one-app solution for your social commerce needs.",
      "image": "assets/splash/splash-one.jpg",
    },
    {
      "title": "Feel the\nease of\nmanaging\nmany orders",
      "subtitle":
      "Imagine running your business this easy.",
      "image": "assets/splash/splash-two.jpg",
    },
    {
      "title": "Deliver\nall your\nproducts,\nfaster than ever",
      "subtitle": "Find the fastest route, save your day.",
      "image": "assets/splash/splash-three.jpg",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return PageView(
        children: [
          SplashContent(splashData: splashData[0]),
          SplashContent(splashData: splashData[1]),
          SplashContent(splashData: splashData[2]),
          SignInScreen()
        ]
    );
  }
}
