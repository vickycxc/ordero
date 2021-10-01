import 'package:fiksii/constants.dart';
import 'package:fiksii/size_config.dart';
import 'package:flutter/material.dart';

import 'otp_form.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.05),
              Text(
                "OTP Verification",
                style: headingStyle,
              ),
              Text("We sent your code to +62 895 0860 ****"),
              buildTimer(),
              SizedBox(height: SizeConfig.screenHeight * 0.15,),
              OtpForm(),
              SizedBox(height: SizeConfig.screenHeight * 0.1,),
              GestureDetector(
                onTap: () {
                  //Resend your OTP
                },
                child: Text(
                  "Resend OTP Code",
                  style: TextStyle(
                    decoration: TextDecoration.underline
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("This code will expired in "),
            TweenAnimationBuilder(
                tween: Tween(begin: 30.0, end: 0.0),
                duration: Duration(seconds: 30), //Because we allow 30s
                builder: (context, value, child) => Text(
                    "00:${double.parse(value.toString()).round()}",
                  style: TextStyle(color: kPrimaryColor),
                ) ,
              onEnd: () {},
            ),
          ],
        );
  }
}

