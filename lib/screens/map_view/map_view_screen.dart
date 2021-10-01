import 'package:fiksii/components/order_format.dart';
import 'package:fiksii/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../size_config.dart';
import 'components/body.dart';

class MapViewScreen extends StatelessWidget {
  const MapViewScreen({Key? key, required this.home, required this.orders}) : super(key: key);

  final Marker home;
  final List<OrderFormat> orders;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Row(
          children: [
            SizedBox(width: 120,),
            Expanded(
              child: Text('Peta', style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Muli',
              ),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              // child: Container(
              //   height: getProportionateScreenHeight(34),
              //   width: getProportionateScreenHeight(34),
              //   decoration:
              //   BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
              // ),
              child: Image.asset('assets/logo/ordero_logo_transparent.png', width: getProportionateScreenHeight(34),height: getProportionateScreenHeight(34),)
            ),
          ],
        ),
      ),
      body: Body(orders: orders,home: home)
    );
  }
}
