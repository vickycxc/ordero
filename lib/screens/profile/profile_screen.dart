import 'package:fiksii/components/firebase_state.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key, required this.user}) : super(key: key);
  final FirebaseState user;

  static String routeName = '/profile';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(user: user,),
    );
  }
}
