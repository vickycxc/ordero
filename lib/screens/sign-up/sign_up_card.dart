import 'package:fiksii/screens/sign_in/components/no_account_text.dart';
import 'package:fiksii/screens/sign_in/components/sign_form.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../../../size_config.dart';

class SignUpCard extends StatelessWidget {
  SignUpCard({
    Key? key,
    required this.controller
  }) : super(key: key);

  PageController controller;

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      width: SizeConfig.screenWidth * 0.9,
      height: SizeConfig.safeScreenHeight * 0.9,
      borderRadius: 32,
      border: 4,
      blur: 2,
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFffffff).withOpacity(0.0),
          Color(0xFFffffff).withOpacity(0.00),
        ],
        stops: [0.1, 1],
      ),
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFffffff).withOpacity(0.1),
          Color(0xFFffffff).withOpacity(0.05),
        ],
        stops: [0.1, 1],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18),
        // width: SizeConfig.screenWidth * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            GlassmorphicContainer(
              height: getProportionateScreenWidth(SizeConfig.screenWidth * 0.4),
              width: getProportionateScreenWidth(SizeConfig.screenWidth * 0.4),
              // padding: EdgeInsets.all(8),
              borderGradient: LinearGradient(colors: [
                Colors.white.withOpacity(0.1),
                Colors.white.withOpacity(0.05),
              ]),
              blur: 2,
              border: 4,
              borderRadius: 200,
              linearGradient: LinearGradient(colors: [
                Colors.white.withOpacity(0.1),
                Colors.white.withOpacity(0.05),
              ],
                  stops: [0.5, 0.9],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset('assets/logo/ordero_logo_transparent.png'),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            Text('Sign Up',style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w800,
                fontSize: getProportionateScreenWidth(28),
                color: Colors.white.withOpacity(0.6)),),
            SizedBox(
              height: getProportionateScreenHeight(40),
            ),
            SignForm(),
            Spacer(),
            Row(),
            NoAccountText(controller: controller,haveAccount: true,),
            Spacer(flex: 3,)
          ],
        ),
      ),
    );
  }
}

