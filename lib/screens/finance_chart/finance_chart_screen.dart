import 'package:fiksii/components/firebase_state.dart';
import 'package:fiksii/constants.dart';
import 'package:flutter/material.dart';

import '../../size_config.dart';
import 'components/body.dart';

class FinanceChartScreen extends StatelessWidget {
  const FinanceChartScreen({Key? key, required this.user}) : super(key: key);
  final FirebaseState user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Row(
          children: [
            SizedBox(width: 80,),
            Expanded(
              child: Text('Laporan Keuangan', style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Muli',
              ),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/logo/ordero_logo_transparent.png', width: getProportionateScreenHeight(34),height: getProportionateScreenHeight(34),)
            ),
          ],
        ),
      ),
      body: Body(user: user,),
    );
  }
}
