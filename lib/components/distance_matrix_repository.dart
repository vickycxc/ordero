import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:fiksii/.env.dart';

class DistanceMatrixRepository {
  DistanceMatrixRepository(List<LatLng> locations) {
    this._locations = locations;
  }
  late List<LatLng> _locations;
  static const String _baseUrl =  'https://maps.googleapis.com/maps/api/distancematrix/json?';
  Future<List<List<int>>?> getDistanceMatrix() async {
    String origins = '';
    String destinations = '';
    bool destFirst = true;
    bool orgFirst = true;
    bool cont = false;
    for (var loc in _locations) {
      String cords = '${loc.latitude}, ${loc.longitude}';
      if (orgFirst) {
        origins += cords;
        orgFirst = false;
        cont = true;
      } else {
        origins += '|$cords';
      }
      if (cont) {
        cont = false;
        continue;
      }
      if (destFirst) {
        destinations += cords;
        destFirst = false;
      } else {
        destinations += '|$cords';
      }
    }
    _locations.forEach((loc) {
    });

    final response = await Dio().get(_baseUrl, queryParameters: {
      'key': APIKEY,
      'origins': origins,
      'destinations': destinations
    });
    if (response.statusCode == 200) {
      // print(response.data);
      return _toMatrix(response.data);
    }
    return null;
  }


  List<List<int>> _toMatrix(Map<String, dynamic> data) {
    List<List<int>> _distanceMatrixes = [];
    List<dynamic> rows = data['rows'];
    rows.forEach((row) {
      List<int> _distanceMatrix = [];
      List<dynamic> distances = row['elements'];
      for (var column in distances) {
        _distanceMatrix.add(column['distance']['value']);
      }
      _distanceMatrixes.add(_distanceMatrix);
    });
    return _distanceMatrixes;
  }
}