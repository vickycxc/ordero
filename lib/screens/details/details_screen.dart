import 'package:fiksii/components/order_format.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'components/body.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key, required this.orderFormat, required this.home}) : super(key: key);

  final Marker home;
  final OrderFormat orderFormat;


  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(home: widget.home, orderFormat: widget.orderFormat,),
    );
  }
}
