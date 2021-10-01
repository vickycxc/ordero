import 'package:fiksii/constants.dart';
import 'package:fiksii/screens/sign_in/sign_in_screen.dart';
import 'package:fiksii/size_config.dart';
import 'package:flutter/material.dart';

import '../components/splash_content.dart';
import '../../../components/default_button.dart';
class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to Ordero, \norganize your business in one app!",
      "image": "assets/images/splash_1.png",
    },
    {
      "text":
          "We help people's business with easy management \naround Indonesia",
      "image": "assets/images/splash_2.png",
    },
    {
      "text": "We show the easy way to manage. \nNo need to worry with us",
      "image": "assets/images/splash_3.png",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"]!,
                  text: splashData[index]["text"]!,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: [
                    Spacer(),
                    Row(
                      children: List.generate(
                          splashData.length, (index) => buildDot(index)),
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    Spacer(flex: 3,),
                    DefaultButton(
                      text: "Continue",
                      press: () {
                        Navigator.pushNamed(context, SignInScreen.routeName);
                      },
                    ),
                    Spacer()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot(int index) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
          color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
          borderRadius: BorderRadius.circular(3)),
    );
  }
}
