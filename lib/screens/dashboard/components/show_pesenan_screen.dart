// import 'package:fiksii/components/pesenan.dart';
// import 'package:flutter/material.dart';
//
// class AddPesenanScreen extends StatefulWidget {
//   const AddPesenanScreen({Key? key}) : super(key: key);
//
//   @override
//   _AddPesenanScreenState createState() => _AddPesenanScreenState();
// }
//
// class _AddPesenanScreenState extends State<AddPesenanScreen> {
//
//   String? _nama;
//   String? _noWa;
//   String? _alamat;
//   String? _jenisBarang;
//   String? _jumlah;
//   String? _koordinat;
//   String? _harga;
//   String? _ongkir;
//   String? _totalHarga;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 125,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.all(Radius.circular(15)),
//         boxShadow: [BoxShadow(
//           blurRadius: 10, color: Colors.grey[300]!, spreadRadius: 5)]
//         ),
//       child: Column(
//       children: [
//         DecoratedTextField(),
//         SheetButton()
//       ],
//       ),
//     );
//   }
// }
//
// class DecoratedTextField extends StatelessWidget {
//   const DecoratedTextField({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 50,
//       alignment: Alignment.center,
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//       margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
//       decoration: BoxDecoration(
//         color: Colors.grey[300],
//         borderRadius: BorderRadius.circular(10)
//       ),
//       child: TextField(
//         decoration: InputDecoration.collapsed(hintText: 'Enter the order'),
//       ),
//     );
//   }
// }
//
// class SheetButton extends StatefulWidget {
//   const SheetButton({Key? key}) : super(key: key);
//
//   @override
//   _SheetButtonState createState() => _SheetButtonState();
// }
//
// class _SheetButtonState extends State<SheetButton> {
//   bool _checkingFLight = false;
//   bool _success = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return !_checkingFLight
//         ? MaterialButton(
//       color: Colors.grey[800],
//       onPressed: () async {
//         setState(() {
//           _checkingFLight = true;
//         });;
//
//         await Future.delayed(Duration(seconds: 1));
//
//         setState(() {
//           _success = true;
//         });
//         await Future.delayed(Duration(milliseconds: 500));
//         Navigator.pop(context);
//       },
//       child: Text(
//         'Check Flight',
//         style: TextStyle(color: Colors.white),
//       ),
//     )
//         : !_success
//         ? CircularProgressIndicator()
//         : Icon(
//       Icons.check,
//       color: Colors.green,
//     );
//   }
// }
