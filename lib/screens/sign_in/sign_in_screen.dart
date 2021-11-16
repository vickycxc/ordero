import 'package:flutter/material.dart';

import 'components/body.dart';
import 'components/new_body.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);
  static String routeName = "/sign_in";

  @override
  Widget build(BuildContext context) {
    return NewBody();
  }
}
