import 'package:fiksii/constants.dart';
import 'package:flutter/material.dart';

import 'components/components/body.dart';

class PrintReceiptScreen extends StatelessWidget {
  const PrintReceiptScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
          centerTitle: true,
        title: Text('Print Receipt', style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
          fontFamily: 'Muli',
        ),),
      ),
      body: Body(),
    );
  }
}
