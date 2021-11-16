import 'package:fiksii/constants.dart';
import 'package:fiksii/screens/sign_in/components/sign_form.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../../../size_config.dart';

class NewBody extends StatelessWidget {
  const NewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.transparent),
      gapPadding: 10,
    );

    return Container(
      color: kPrimaryColor,
      child: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: SizeConfig.safeScreenHeight,
            width: SizeConfig.screenWidth,
            child: Stack(
              children: [
                Image.asset(
                  'assets/splash/login.jpg',
                  fit: BoxFit.cover,
                  height: SizeConfig.safeScreenHeight,
                  width: SizeConfig.screenWidth,
                ),
                Container(
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
                Center(
                  child: GlassmorphicContainer(
                    width: SizeConfig.screenWidth * 0.9,
                    height: SizeConfig.screenHeight * 0.9,
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
                          child: SignForm(outlineInputBorder: outlineInputBorder),
                        ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

