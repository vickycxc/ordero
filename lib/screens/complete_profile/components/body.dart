import 'package:fiksii/constants.dart';
import 'package:fiksii/size_config.dart';
import 'package:flutter/material.dart';

import 'complete_profile_form.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight* 0.02),
                Text(
                  "Lengkapi Profil",
                  style: headingStyle,
                ),
                Text(
                  "Lengkapi profil anda agar semua fitur Ordero dapat berfungsi secara maksimal",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight* 0.025),
                CompleteProfileForm(),
                SizedBox(height: getProportionateScreenHeight(30),),
                // Text(
                //   "Klik continue untuk melanjutkan"
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
