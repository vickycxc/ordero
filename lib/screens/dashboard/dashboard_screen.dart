
import 'package:fiksii/components/custom_app_bar.dart';
import 'package:fiksii/components/firebase_state.dart';
import 'package:fiksii/components/order_format.dart';
import 'package:fiksii/screens/dashboard/components/card.dart';
import 'package:fiksii/size_config.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key, required this.orders, required this.user}) : super(key: key);

  final FirebaseState user;
  final List<OrderFormat> orders;

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: CustomAppBar(),
        body: CustomScrollView(
            slivers: [
                CustomAppBar(home: widget.user.home!, pesananAktif: widget.orders.length, totalTransaksi: getTotalTransaksi(widget.orders), namaBisnis: widget.user.namaBisnis!),
                SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                  OrderFormat pesenanData = widget.orders[index];

                  return Container(
                      // color: Colors.black26,
                      width: SizeConfig.screenWidth,
                      child: PesenanRow(pesenan: pesenanData,home: widget.user.home!));
                }, childCount: widget.orders.length)),
                // SliverToBoxAdapter(
                //   child: Container(
                //       height: 13.0,
                //       width: SizeConfig.screenWidth,
                //       color: (ordersSnapshot.length != 0)
                //           ? Colors.black26
                //           : Colors.white),
                // ),
              ]
      )
    );
  }

  int getTotalTransaksi(List<OrderFormat> orders) {
    int hargaSementara = 0;
    orders.forEach((order) {
      hargaSementara += order.total;
    });
    return hargaSementara;
  }

}
