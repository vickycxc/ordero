import 'package:flutter/material.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:fiksii/.env.dart';

class MapCard extends StatefulWidget {
  const MapCard({
    Key? key,
    required this.onMapCreated,
    required this.onPicked,
    this.clickable = false,
    this.initialCamera,
    required this.markers,
    required this.height,
    this.polylines = const {}}) : super(key: key);



  final bool clickable;
  final Function(LocationResult res) onPicked;
  final Set<Marker> markers;
  final Set<Polyline> polylines;
  final double height;
  final CameraPosition? initialCamera;
  final Function(GoogleMapController controller) onMapCreated;



  static Marker buildMarker(LatLng pos) {
    return Marker(
      markerId: MarkerId('location'),
      infoWindow: InfoWindow(title: 'Location'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      position: pos,
    );
  }

  static Future<Marker> getHomeMarker(LatLng cords) async {
    return Marker(
        markerId: MarkerId('home'),
        infoWindow: InfoWindow(title: 'Home'),
        position: cords,
        icon: await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(), 'assets/icons/shop-icon.png',
        )

      // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    );
  }

  @override
  MapCardState createState() => MapCardState();
}


class MapCardState extends State<MapCard> {
  // Marker? _location;
  // Marker? _home;
  // void moveCamera(CameraUpdate cameraUpdate) {
  //   // if (_googleMapController != null)
  //   //   _googleMapController!.animateCamera(cameraUpdate);
  // }

  // GoogleMapController? _googleMapController;

  // @override
  // void dispose() {
  //   // _googleMapController?.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        // color: Colors.green,
        width: double.infinity,
        height: widget.height,
        child:
        Stack(
          children: [
            GoogleMap(    //TODO Location Picker
              onMapCreated: (controller) => widget.onMapCreated(controller),
              markers: widget.markers,
              polylines: widget.polylines,
              initialCameraPosition: (widget.initialCamera != null) ? widget.initialCamera! :CameraPosition(target: widget.markers.last.position,zoom: 13.5),
              zoomControlsEnabled: false,
              scrollGesturesEnabled: false,
              rotateGesturesEnabled: false,
              zoomGesturesEnabled: false,


            ),
            TextButton(
              onPressed: () async {
                if (widget.clickable) {
                  LocationResult? result = await showLocationPicker(
                    context,
                    APIKEY,
                    initialCenter: widget.markers.last.position,
                    initialZoom: 14,
                    layersButtonEnabled: true,
                    desiredAccuracy: LocationAccuracy.best,

                  );

                  if (result?.latLng != null) {
                    widget.onPicked(result!);

                    // _googleMapController.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(target: result.latLng!, zoom: 13.5)));
                  }
                }
              },
              child: Container(width: double.infinity, height: double.infinity,),
              style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith((states) => Colors.black12)
              ),
            )
          ],
        ),
      ),
    );
  }
}
