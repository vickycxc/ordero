import 'package:fiksii/screens/add_pesenan/components/body.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// class AddPesenanScreen extends StatefulWidget {
//   const AddPesenanScreen({Key? key, this.uri}) : super(key: key);
//   static String routeName = "/add_pesenan";
//   final Uri? uri;
//   @override
//   _AddPesenanScreenState createState() => _AddPesenanScreenState();
// }
//
// class _AddPesenanScreenState extends State<AddPesenanScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   backgroundColor: Colors.amber,
//       //   // title: Text(''),
//       // ),
//         body: Body(uri: widget.uri,)
//     );
//   }
// }


class AddPesenanScreen extends StatelessWidget {
  const AddPesenanScreen({Key? key, this.uri, required this.home}) : super(key: key);
  // static String routeName = "/add_pesenan";
  final Uri? uri;
  final Marker home;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(home: home,uri: uri),
    );
  }
}
