// import 'package:clipboard/clipboard.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fiksii/components/default_button.dart';
// import 'package:fiksii/components/firebase_state.dart';
// import 'package:fiksii/components/my_back_button.dart';
// import 'package:fiksii/components/top_container.dart';
// import 'package:fiksii/size_config.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class Body extends StatefulWidget {
//   const Body({Key? key}) : super(key: key);
//
//   @override
//   _BodyState createState() => _BodyState();
// }
//
// class _BodyState extends State<Body> with WidgetsBindingObserver {
//   String text = '';
//
//   TextEditingController barangController = TextEditingController();
//   TextEditingController jumlahController = TextEditingController();
//   TextEditingController namaController = TextEditingController();
//   TextEditingController kontakController = TextEditingController();
//   TextEditingController alamatController = TextEditingController();
//   TextEditingController hargaController = TextEditingController();
//   TextEditingController latitudeController = TextEditingController();
//   TextEditingController longitudeController = TextEditingController();
//
//   final _formKey = GlobalKey<FormState>();
//   String? nama;
//   String? kontak;
//   String? alamat;
//   String? jenisBarang;
//   String? jumlah;
//   String? latitude;
//   String? longitude;
//   String? harga;
//   String? ongkir;
//   String? totalHarga;
//
//   void parseOrder() {
//     Map order = {};
//
//     var texts = text.split('\n');
//
//     for (String subText in texts) {
//       if (subText.contains(':')) {
//         var subTexts = subText.split(':');
//         order[subTexts[0]] = subTexts[1].trim();
//       }
//     }
//
//     namaController.text = order['Nama'] ?? '';
//     alamatController.text = order['Alamat'] ?? '';
//     kontakController.text = order['No telp'] ?? '';
//     jumlahController.text = order['Jumlah'] ?? '';
//     barangController.text = order['Nama merch'] ?? '';
//   }
//
//   Future<void> scanClipboard() async {
//     String value = await FlutterClipboard.paste();
//     print('Value from Function: $value\n\n');
//     print('Text from Function: $text\n\n');
//     text = value;
//   }
//
//   @override
//   void initState() {
//     WidgetsBinding.instance!.addObserver(this);
//     scanClipboard().then((value) => setState(() {}));
//     namaController.text = 'Okeee';
//   }
//
//   @override
//   void dispose() {
//     WidgetsBinding.instance!.removeObserver(this);
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed) {
//       scanClipboard().then((value) => setState(() {}));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     //TODO ngasih centang auto isi apa engga
//
//     return SingleChildScrollView(
//       child: SafeArea(
//         child: Form(
//           key: _formKey,
//           child: Container(
//             color: Color(0xFFFFD7B2),
//             height: SizeConfig.screenHeight,
//             child: Column(
//               children: [
//                 TopContainer(
//                   padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
//                   width: SizeConfig.screenWidth,
//                   // height: SizeConfig.screenHeight * 0.4,
//                   child: Column(
//                     children: [
//                       MyBackButton(),
//                       SizedBox(
//                         height: 30,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Tambah Pesanan',
//                             style: TextStyle(
//                                 fontSize: 30.0,
//                                 fontWeight: FontWeight.w600,
//                                 fontFamily: 'Poppins',
//                                 color: Colors.white),
//                           ),
//                           SizedBox(
//                             height: 20,
//                           ),
//                           Container(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 // MyTextField(label: 'Nama', icon: CustomSuffixIcon(
//                                 //   svgIcon: "assets/icons/User.svg",
//                                 // ))
//                               ],
//                             ),
//                           ),
//                           Expanded(
//                             child: Container(),
//                           ),
//                           SizedBox(
//                             height: 20,
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Row(
//                         children: [
//                           Expanded(
//                             flex: 15,
//                             child: buildPesenanFormField(
//                               'Barang',
//                               controller: barangController,
//                               onSaved: (value) => jenisBarang = value,
//                             ),
//                           ),
//                           SizedBox(
//                             width: 20.0,
//                           ),
//                           Expanded(
//                               flex: 10,
//                               child: buildPesenanFormField(
//                                 'Jumlah',
//                                 controller: jumlahController,
//                                 onSaved: (value) => jumlah = value,
//                               ))
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                   child: Row(
//                     children: [
//                       Expanded(
//                           flex: 1,
//                           child: buildPesenanFormField(
//                             'Nama',
//                             controller: namaController,
//                             onSaved: (value) => nama = value,
//                           )),
//                       SizedBox(
//                         width: 20.0,
//                       ),
//                       Expanded(
//                           flex: 1,
//                           child: buildPesenanFormField(
//                             'No. Wa',
//                             controller: kontakController,
//                             onSaved: (value) => kontak = value,
//                           )),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 40),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                   child: Row(
//                     children: [
//                       Expanded(
//                           flex: 4,
//                           child: buildPesenanFormField(
//                             'Alamat',
//                             controller: alamatController,
//                             onSaved: (value) => alamat = value,
//                           )),
//                       SizedBox(
//                         width: 20.0,
//                       ),
//                       Expanded(
//                           flex: 2,
//                           child: buildPesenanFormField(
//                             'Harga',
//                             controller: hargaController,
//                             onSaved: (value) => harga = value,
//                           )),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 30),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                   child: Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         'Koordinat:',
//                         style: TextStyle(color: Colors.white),
//                       )),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                   child: Row(
//                     children: [
//                       Expanded(
//                           flex: 4,
//                           child: buildPesenanFormField(
//                             'Latitude',
//                             controller: latitudeController,
//                             onSaved: (value) => latitude = value,
//                           )),
//                       SizedBox(
//                         width: 20.0,
//                       ),
//                       Expanded(
//                           flex: 4,
//                           child: buildPesenanFormField(
//                             'Longitude',
//                             controller: longitudeController,
//                             onSaved: (value) => longitude = value,
//                           )),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 40,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                   child:
//                   Consumer<FirebaseState>(builder: (context, value, child) {
//                     DocumentReference orderReference =
//                     FirebaseFirestore.instance.collection('orders').doc();
//                     return DefaultButton(
//                         text: 'Simpan',
//                         press: () {
//                           // if (_formKey.currentState!.validate()) {
//                           //   _formKey.currentState!.save();
//                           //   orderReference.set({
//                           //     'uid': value.uid,
//                           //     'date_created': Timestamp.now(),
//                           //     'order_status': 'active',
//                           //     'nama_barang': jenisBarang,
//                           //     'kuantitas': jumlah,
//                           //     'harga': harga,
//                           //     'pembeli': {
//                           //       'alamat': alamat,
//                           //       'nama': nama,
//                           //       'kontak': kontak,
//                           //       'koordinat': {'lng': longitude, 'ltd': latitude}
//                           //     }
//                           //   });
//                           //   Navigator.pop(context);
//                           // }
//                           namaController.value = TextEditingValue(text: 'cuma');
//                         });
//                   }),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
// // TextFormField buildNamaFormField() {
// //   return TextFormField(
// //       onSaved: (newValue) => nama = newValue!,
// //       decoration: InputDecoration(
// //           labelText: "Last Name",
// //           labelStyle: TextStyle(color: Color(0xFF8B8B8B)),
// //           hintText: "Enter your last name",
// //           floatingLabelBehavior: FloatingLabelBehavior.always,
// //           suffixIcon: CustomSuffixIcon(
// //             svgIcon: "assets/icons/User.svg",
// //           )));
// // }
//
//   TextFormField buildPesenanFormField(String title,
//       {Color color = Colors.white,
//         TextEditingController? controller,
//         void Function(String?)? onSaved}) {
//     return TextFormField(
//       onSaved: onSaved,
//       decoration: InputDecoration(
//         contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(14),
//           borderSide: BorderSide(color: color),
//           // gapPadding: 0,
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(14),
//           borderSide: BorderSide(color: color),
//           // gapPadding: 0,
//         ),
//         labelText: title,
//         labelStyle: TextStyle(color: color),
//         // hintText: "Enter your first name",
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         // suffixIcon: CustomSuffixIcon(
//         //   svgIcon: "assets/icons/User.svg",
//         // )
//       ),
//     );
//   }
// }
