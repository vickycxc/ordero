import 'package:fiksii/screens/sign-up/sign_up_card.dart';
import 'package:fiksii/screens/sign-up/sign_up_screen.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class NoAccountText extends StatelessWidget {
  NoAccountText({
    Key? key,
    required this.controller,
    required this.haveAccount
  }) : super(key: key);

  PageController controller;
  bool haveAccount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          haveAccount ? "Already have an account? " : "Don't have an account? ",
          style: TextStyle(fontSize: getProportionateScreenWidth(16),fontFamily: 'Poppins',color: Colors.white54),
        ),
        GestureDetector(
          onTap: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpCard()));
            haveAccount ? controller.previousPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn): controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn);
          },
          child: Text(
            haveAccount? "Sign In" : "Sign Up",
            style: TextStyle(fontSize: getProportionateScreenWidth(16),
                color: Colors.white70,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins'),
          ),
        ),
      ],
    );
  }
}
