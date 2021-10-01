import 'package:fiksii/components/firebase_state.dart';
import 'package:fiksii/screens/finance_chart/components/bar_chart.dart';
import 'package:fiksii/screens/finance_chart/components/stats.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  final FirebaseState user;

  const Body({Key? key, required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black26,
      // height: SizeC,
      child: Column(
        children: [
          CovidBarChart(covidCases: [200, 323, 193, 400, 323, 250]),
          Stats(user: user,)
        ],
      ),
    );
  }
}
