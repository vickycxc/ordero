import 'package:fiksii/components/directions_repository.dart';
import 'package:fiksii/components/distance_matrix_repository.dart';
import 'package:fiksii/components/order_format.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteCalculations {
  final List<LatLng> _locations;
  const RouteCalculations(this._locations);

  Future<List<int>> _calculateRuteTercepat() async {
    var matrix = await DistanceMatrixRepository(_locations).getDistanceMatrix();
    List<int> urutan = [];
    int iPointer = 0;
    List<int> iIgnoreGlobal = [];
    while (iIgnoreGlobal.length != matrix!.length - 1) {
      int? iFastestRoute;
      int? durasiTerpendek;
      int iDestination = 0;
      List<int> _iIgnoreLocal = iIgnoreGlobal;
      for (var durasi in matrix[iPointer]) {
        bool skip = false;
        for (var i in _iIgnoreLocal) {
          if (iDestination == i) {
            skip = true;
          }
        }
        if (skip) {
          iDestination++;
          continue;
        }
        if (durasiTerpendek == null) {
          durasiTerpendek = durasi;
          iFastestRoute = iDestination;
        }
        if (durasi < durasiTerpendek) {
          durasiTerpendek = durasi;
          iFastestRoute = iDestination;
        }
        iDestination++;
      }
      urutan.add(iFastestRoute! + 1);
      iIgnoreGlobal.add(iFastestRoute);
      iPointer = iFastestRoute + 1;
    }
    return urutan;
  }

  Future<List<int>> _calculateFastestRouteWithPermutation() async {
    final List<List<int>>? matrix = await DistanceMatrixRepository(_locations).getDistanceMatrix();
    List<int> size = [];
    List<int> durations = [];
    for (var i = 1; i<matrix!.length; i++) {
      size.add(i);
    }
    var permutation = findAllPermutations(size);
    for (var route in permutation) {
      var lastPointer = 0;
      var duration = 0;
      for (var pointer in route) {
        duration += matrix[lastPointer][pointer - 1];
        lastPointer = pointer;
      }
      durations.add(duration);
    }
    int pointer = 0;
    int? fastestRoute;
    int? iPointer;
    for (var dur in durations) {
      if (fastestRoute == null) {
        fastestRoute = dur;
        iPointer = pointer;
        pointer++;
        continue;
      } else {
        if (fastestRoute > dur) {
          fastestRoute = dur;
          iPointer = pointer;
        }
        pointer++;
      }
    }
    // print('duration: $fastestRoute');
    // print('pointer: $iPointer');
    // print('route: ${permutation[iPointer!]}');
    return permutation[iPointer!];
  }

  List<List<int>> findAllPermutations(List<int> source) {
    List<List<int>> allPermutations = [];

    void permutate(List<int> list, int cursor) {
      // when the cursor gets this far, we've found one permutation, so save it
      if (cursor == list.length) {
        allPermutations.add(list);
        return;
      }

      for (int i = cursor; i < list.length; i++) {
        List<int> permutation = new List.from(list);
        permutation[cursor] = list[i];
        permutation[i] = list[cursor];
        permutate(permutation, cursor + 1);
      }
    }

    permutate(source, 0);

    List<List<int>> strPermutations = [];
    for (List<int> permutation in allPermutations) {
      strPermutations.add(permutation);
    }

    return strPermutations;
  }

  Future<List<String>> getDirections() async {
    var arah = await _calculateFastestRouteWithPermutation();
    int prevIndex = 0;
    List<String> _directions = [];

    for (var i in arah) {
      var poly = await DirectionsRepository.getDirections(origin: _locations[prevIndex], destination: _locations[i]);
      _directions.add(poly!.polyline);
      prevIndex = i;
    }
    return _directions;
  }

  factory RouteCalculations.fromUserState(LatLng home, List<OrderFormat> orderan) {
    List<LatLng> myLocations = [];
    myLocations.add(home);
    orderan.forEach((order) {
      LatLng latLng = LatLng(order.pembeli.koordinat.latitude, (order.pembeli.koordinat.longitude));
      myLocations.add(latLng);
    });
    return RouteCalculations(myLocations);
  }
}