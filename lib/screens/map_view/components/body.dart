import 'package:fiksii/components/map_card.dart';
import 'package:fiksii/components/order_format.dart';
import 'package:fiksii/screens/map_view/components/route_calculations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Body extends StatelessWidget {
  Body({Key? key, required this.home, required this.orders}) : super(key: key);

  final Marker home;
  final List<OrderFormat> orders;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};

  @override
  Widget build(BuildContext context) {
    orders.forEach((order) {
        Marker marker = MapCard.buildMarker(LatLng(order.pembeli.koordinat.latitude, order.pembeli.koordinat.longitude));
        markers.add(marker);
    });
    markers.add(home);
    var routeCalc = RouteCalculations.fromUserState(home.position, orders);
    // setMap(routeCalc);
    return FutureBuilder<List<String>>(
      future: routeCalc.getDirections(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) setRoute(snapshot.data!);
        }
        return GoogleMap(
              initialCameraPosition: CameraPosition(target: home.position,zoom: 13),
              rotateGesturesEnabled: false,
              zoomControlsEnabled: false,
              markers: markers,
              polylines: polylines,
            );
      }
    );
  }
  void setRoute(List<String> route) {
    int index = 0;
    route.forEach((subRoute) {
      var polyline = Polyline(
                polylineId: PolylineId('sub-route $index'),
                color: Color.fromARGB(255, 232, 111, 139),
                width: 5,
                points: PolylinePoints().decodePolyline(subRoute).map((e) => LatLng(e.latitude, e.longitude)).toList()
            );
      polylines.add(polyline);
      index++;
    });
    // markers.add(home);
    // orders.forEach((order) {
    //   Marker marker = MapCard.buildMarker(LatLng(order.pembeli.koordinat.latitude, order.pembeli.koordinat.longitude));
    //   Polyline polyline = Polyline(
    //       polylineId: PolylineId('overview_polyline'),
    //       color: Color.fromARGB(255, 232, 111, 139),
    //       width: 5,
    //       points: PolylinePoints().decodePolyline(order.pembeli.polyline).map((e) => LatLng(e.latitude, e.longitude)).toList()
    //   );
    //   markers.add(marker);
    //   polylines.add(polyline);
    // });

  }
}
