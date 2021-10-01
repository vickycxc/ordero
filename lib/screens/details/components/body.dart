import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiksii/components/default_button.dart';
import 'package:fiksii/components/firebase_state.dart';
import 'package:fiksii/components/map_card.dart';
import 'package:fiksii/components/my_back_button.dart';
import 'package:fiksii/components/order_format.dart';
import 'package:fiksii/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../size_config.dart';

class Body extends StatefulWidget {
  const Body({Key? key, required this.orderFormat, required this.home}) : super(key: key);

  final Marker home;
  final OrderFormat orderFormat;

  @override
  _BodyState createState() => _BodyState();
}


class _BodyState extends State<Body> {
  String _url = "https://api.whatsapp.com/send?phone=62";
  late Polyline route;
  late Marker location;
  GoogleMapController? _controller;
  

  void sendMessage(context) {
    String txt = widget.orderFormat.pembeli.kontak;
    if (txt[0] == '0') {
      txt = txt.substring(1);
    } else if (txt[0] == '+') {
      txt = txt.substring(4);
    }
    _launchURL(txt);
  }

  void _launchURL(txt) async => await canLaunch(_url + txt)
      ? await launch(_url + txt)
      : throw 'Could not launch $_url';


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              color: kPrimaryColor, width: SizeConfig.screenWidth, height: SizeConfig.screenHeight * 0.8,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(60, 10, 30, 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(widget.orderFormat.namaBarang,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold, fontSize: 28,
                            color: Colors.black87
                        )
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text('${widget.orderFormat.kuantitas} Pcs',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold, fontSize: 20,
                              color: Colors.black87
                          )
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 65, 0, 20),
              child: MapCard(
                onMapCreated: (controller) async {
                  _controller = controller;
                  await Future.delayed(Duration(milliseconds: 200));
                  if (_controller != null)_controller!.animateCamera(CameraUpdate.newLatLngBounds(widget.orderFormat.pembeli.bounds, 40.0));
                },
                height: getProportionateScreenHeight(280),

                onPicked: (res) {},
                markers: {
                  widget.home,
                  location
                },
                polylines: {
                  route
                },
              ),
            ),
            Container(
                // color: Colors.green,
                width: SizeConfig.screenWidth,
                height: getProportionateScreenHeight(980),
                child: Column(
                  children: [
                    Container(
                        color: Colors.transparent,
                        height: getProportionateScreenHeight(300),
                        // width: SizeConfig.screenWidth,
                      ),
                    Expanded(
                      child: Container(
                        width: SizeConfig.screenWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32.0),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.fromLTRB(20, 40, 25, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildDisplayDetails('Nama Pembeli','${widget.orderFormat.kuantitas} Pcs'),
                                  _buildDisplayDetails('Alamat', widget.orderFormat.pembeli.alamat,fontSize: 16),
                                  _buildDisplayDetails('Harga', FirebaseState.asRupiah(widget.orderFormat.harga)),
                                  _buildDisplayDetails('Total Harga', FirebaseState.asRupiah(widget.orderFormat.total)),
                                  _buildDisplayDetails('Order Status', widget.orderFormat.orderStatus),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildDisplayDetails('Kontak',widget.orderFormat.pembeli.kontak),
                                  _buildDisplayDetails('Jarak', '${widget.orderFormat.pembeli.jarak} km'),
                                  _buildDisplayDetails('Ongkir', FirebaseState.asRupiah(widget.orderFormat.ongkir)),
                                  _buildDisplayDetails('Tanggal Dibuat', FirebaseState.formatDate(widget.orderFormat.dateCreated.toDate()),fontSize: 16),
                                  _buildDisplayDetails('ID', widget.orderFormat.barangId),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 15),
                        child: DefaultButton(text: 'Hubungi Pembeli', press: () {
                          sendMessage(context);
                        },color: Colors.green.shade300,)
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 20, 15),
                        child: DefaultButton(text: 'Cetak Struk', press: () {
                        },color: Colors.red.shade300,)
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 15),
                      child: DefaultButton(text: 'Selesaikan Pesanan', press: () {
                        DocumentReference orderReference =
                        FirebaseFirestore.instance.doc('orders/${widget.orderFormat.id}');
                        orderReference.update({
                          'order_status': 'finished'
                        });
                        Navigator.pop(context);
                      },)
                    ),
                  ],
                ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(25,20,20,20),
              child: MyBackButton(),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildDisplayDetails(String header, String body, {double fontSize = 20}) {
    return Container(
      height: 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(header,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600, fontSize: 20,
                  color: Colors.black
              )
          ),
          Text(body,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontFamily: 'Poppins', fontSize: fontSize,
                  color: Colors.black
              )
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    GeoPoint geo = widget.orderFormat.pembeli.koordinat;
    location = MapCard.buildMarker(LatLng(geo.latitude, geo.longitude));
    route = Polyline(
        polylineId: PolylineId('overview_polyline'),
        color: Color.fromARGB(255, 232, 111, 139),
        width: 5,
        points: PolylinePoints().decodePolyline(widget.orderFormat.pembeli.polyline).map((e) => LatLng(e.latitude, e.longitude)).toList()
    );
  }
}
