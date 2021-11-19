import 'package:flutter/material.dart';


class InitializeScreen extends StatelessWidget {
  const InitializeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              // color: kPrimaryColor
          ),
          Center(child: Image.asset('assets/logo/orderly_logo.png'))
        ],
      ),
    );
  }
}
