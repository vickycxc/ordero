import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class Directions {
  final LatLngBounds bounds;
  final List<PointLatLng> polylinePoints;
  final String totalDistance;
  final String totalDuration;
  final String polyline;

  const Directions({required this.bounds,
    required this.polylinePoints,
    required this.totalDistance,
    required this.totalDuration,
    required this.polyline});

  factory Directions.fromMap(Map<String, dynamic> map) {
    if ((map['routes'] as List).isNotEmpty) {
      //Get route information
      final data = Map<String, dynamic>.from(map['routes'][0]);

      //Bounds
      final northeast = data['bounds']['northeast'];
      final southwest = data['bounds']['southwest'];
      final bounds = LatLngBounds(
          southwest: LatLng(southwest['lat'], southwest['lng']),
          northeast: LatLng(northeast['lat'], northeast['lng']));

      //Distance & Duration
      String distance = '';
      String duration = '';
      if ((data['legs'] as List).isNotEmpty) {
        final leg = data['legs'][0];
        distance = leg['distance']['text'];
        duration = leg['duration']['text'];
      }
      String polyline = data['overview_polyline']['points']!;
      return Directions(
          bounds: bounds,
          polylinePoints: PolylinePoints().decodePolyline(
              polyline),
          totalDistance: distance,
          totalDuration: duration,
          polyline: polyline

      );
    } else {
      throw ArgumentError('Unexpected Error');
    }
  }
}