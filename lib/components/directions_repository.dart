import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dio/dio.dart';

import 'package:fiksii/.env.dart';
import 'directions_model.dart';

class DirectionsRepository {
  static const String _baseUrl = 'https://maps.google.com/maps/api/directions/json?';

  static Future<Directions?> getDirections({
  required LatLng origin,
    required LatLng destination,
}) async {
    final response = await Dio().get(_baseUrl, queryParameters: {
      'origin': '${origin.latitude}, ${origin.longitude}',
      'destination': '${destination.latitude}, ${destination.longitude}',
      'key': APIKEY
    });

    //Check if response is successful
    if (response.statusCode == 200) {
    // print(response.data);
      return Directions.fromMap(response.data);
    }
    return null;
  }
}
