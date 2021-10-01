import 'package:fiksii/screens/complete_profile/complete_profile_screen.dart';
import 'package:fiksii/screens/initialize/initialize_screen.dart';
import 'package:fiksii/screens/main_screen/main_screen.dart';
import 'package:fiksii/screens/splash/splash_screen.dart';
import 'package:fiksii/size_config.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key, required this.loginState, required this.completeProfile}) : super(key: key);
  final LoginState? loginState;
  final bool? completeProfile;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    switch (loginState) {
      case LoginState.loggedOut:
        return SplashScreen();
      case LoginState.loggedIn:
        return (completeProfile != false) ? MainScreen() : CompleteProfileScreen();
      default:
        return InitializeScreen();
    }
  }
}
