import 'package:fiksii/components/social_card.dart';
import 'package:fiksii/constants.dart';
import 'package:fiksii/size_config.dart';
import 'package:flutter/material.dart';

import 'sign_up_form.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.02,),
              Text(
                "Register Account",
                style: headingStyle,
              ),
              Text(
                "Complete your details or continue \nwith social",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.07,),
              SignUpForm(),
              SizedBox(height: SizeConfig.screenHeight * 0.07,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialCard(
                      press: () {},
                      icon: "assets/icons/google-icon.svg"),
                  SocialCard(
                      press: () {},
                      icon: "assets/icons/facebook-2.svg"),
                  SocialCard(
                      press: () {},
                      icon: "assets/icons/twitter.svg"),
                ],
              ),
              Text(
                "By continuing your confirm that you agree with \nour Term and Condition",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


