import 'package:fiksii/screens/sign-up/sign_up_card.dart';
import 'package:fiksii/screens/sign-up/sign_up_screen.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyle(fontSize: getProportionateScreenWidth(16),fontFamily: 'Poppins',color: Colors.white54),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpCard()));
          },
          child: Text(
            "Sign Up",
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
