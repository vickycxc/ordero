import 'package:fiksii/components/no_account_text.dart';
import 'package:fiksii/constants.dart';
import 'package:fiksii/screens/sign_in/components/sign_form.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../../../size_config.dart';
import 'login_card.dart';

class NewBody extends StatelessWidget {
  const NewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      color: kPrimaryColor,
      child: SafeArea(
        child: SizedBox(
          height: SizeConfig.safeScreenHeight,
          width: SizeConfig.screenWidth,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Image.asset(
                  'assets/splash/login.jpg',
                  fit: BoxFit.cover,
                  height: SizeConfig.safeScreenHeight,
                  width: SizeConfig.screenWidth,
                ),
              ),
              SingleChildScrollView(
                child: Container(
                height: SizeConfig.safeScreenHeight,
                width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          end: Alignment.topLeft,
                          colors: [
                        kColorOne.withOpacity(0.9),
                        kColorTwo.withOpacity(0.8),
                        kColorThree.withOpacity(0.9)
                      ],
                          stops: [
                        0.1,
                        0.6,
                        0.95
                      ])),
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.05, vertical: SizeConfig.safeScreenHeight * 0.05),
                  child: LoginCard(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}