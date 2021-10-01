import 'package:fiksii/screens/complete_profile/complete_profile_screen.dart';
import 'package:fiksii/screens/forgot_password/forgot_password_screen.dart';
import 'package:fiksii/screens/login_success/login_success_screen.dart';
import 'package:fiksii/screens/otp/otp_screen.dart';
import 'package:fiksii/screens/sign-up/sign_up_screen.dart';
import 'package:fiksii/screens/sign_in/sign_in_screen.dart';
import 'package:fiksii/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
 // MainMenu.routeName: (context) => MainMenu(),
 //  AddPesenanScreen.routeName: (context) => AddPesenanScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
};