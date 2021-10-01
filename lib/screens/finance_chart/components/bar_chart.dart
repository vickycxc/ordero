import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CovidBarChart extends StatelessWidget {
  const CovidBarChart({Key? key, required this.covidCases}) : super(key: key);

  final List<double> covidCases;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: kPrimaryColor,
      // alignment: Alignment.centerLeft,
      height: 350.0,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0))),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Laporan mingguan',
              style:
              const TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
          ),
          Flexible(
            child: Container(
              // height: 450,
              width: MediaQuery.of(context).size.width * 0.85,
              child: BarChart(BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 500,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: SideTitles(
                      margin: 10.0,
                      showTitles: true,
                      getTextStyles: (context, value) => TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                      rotateAngle: 35.0,
                      getTitles: (value) {
                        switch (value.toInt()) {
                          case 0:
                            return 'Pekan 1';
                          case 1:
                            return 'Pekan 2';
                          case 2:
                            return 'Pekan 3';
                          case 3:
                            return 'Pekan 4';
                          case 4:
                            return 'Pekan 5';
                          case 5:
                            return 'Pekan 6';
                          case 6:
                            return 'Pekan 6';
                          default:
                            return '';
                        }
                      },
                    ),
                    leftTitles: SideTitles(
                      margin: 10.0,
                      showTitles: true,
                      getTextStyles: (value, double) => TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                      ),
                      getTitles: (value) {
                        if (value == 0) {
                          return '0';
                        } else if (value % 3 == 0) {
                          return '${value ~/ 3 * 5}K';
                        }
                        return '';
                      },
                    ),
                  ),
                  gridData: FlGridData(
                    checkToShowHorizontalLine: (value) => value % 3 == 0,
                    getDrawingHorizontalLine: (value) => FlLine(
                        color: Colors.black12,
                        strokeWidth: 1.0,
                        dashArray: [5]
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: covidCases
                      .asMap()
                      .map((key, value) => MapEntry(
                      key,
                      BarChartGroupData(x: key, barRods: [
                        BarChartRodData(y: value, colors: [Colors.red])
                      ])))
                      .values
                      .toList())),
            ),
          ),
          SizedBox(height: 40,)
        ],
      ),
    );
  }
}
