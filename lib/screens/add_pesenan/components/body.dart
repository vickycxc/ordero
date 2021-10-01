import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiksii/components/default_button.dart';
import 'package:fiksii/components/directions_model.dart';
import 'package:fiksii/components/directions_repository.dart';
import 'package:fiksii/components/firebase_state.dart';
import 'package:fiksii/components/map_card.dart';
import 'package:fiksii/components/my_back_button.dart';
import 'package:fiksii/components/top_container.dart';
import 'package:fiksii/constants.dart';
import 'package:fiksii/size_config.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';


class Body extends StatefulWidget {
  const Body({Key? key, this.uri, required this.home}) : super(key: key);
  final Uri? uri;
  final Marker home;
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  // final _mapKey = GlobalKey<MapCardState>();
  GoogleMapController? _controller;


  TextEditingController _barangController = TextEditingController();
  TextEditingController _jumlahController = TextEditingController();
  TextEditingController _namaController = TextEditingController();
  TextEditingController _kontakController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();
  TextEditingController _hargaController = TextEditingController();
  // TextEditingController _latitudeController = TextEditingController();
  // TextEditingController _longitudeController = TextEditingController();

  late String _nama;
  late String _kontak;
  late String _alamat;
  late String _barang;
  late String _barangId;
  late int _jumlah;
  // late double _latitude;
  // late double _longitude;
  double? _distance;
  late int _harga;
  bool _alamatIsEmpty = true;
  int? _ongkir;
  late int _tarifOngkirPerKm;
  late int _totalHarga;
  LatLngBounds? _bounds;
  // String? _polylines;

  Marker? _location;
  Directions? _route;

  final List<Tuple2<String, String>> errors = [];

  void _addError({required String error, required String atController}) {
    if (!error.contains(error))
      setState(() {
        errors.add(Tuple2(error, atController));
      });
  }

  void _removeError({required String error, required String atController}) {
    if (error.contains(error))
      setState(() {
        errors.remove(Tuple2(error, atController));
      });
  }

  void _parseFromClipboard() async {
    Map orderDetails = {};
    String text = await FlutterClipboard.paste();
    List<String> texts = text.split('\n');



    for (String subText in texts) {
      if (subText.contains(':')) {
        List<String> subTexts = subText.split(':');
        orderDetails[subTexts[0]] = subTexts[1].trim();
      }
    }
    if (texts[0] == '[Format Order]') {
      String alamat = orderDetails['Alamat'] ?? '';
      if (alamat.isNotEmpty) _alamatIsEmpty = false;
      _namaController.text = orderDetails['Nama'] ?? '';
      _alamatController.text = alamat;
      _kontakController.text = orderDetails['No. Telp'] ?? '';
      _jumlahController.text = orderDetails['Jumlah'] ?? '';
      _barangController.text = orderDetails['Barang'] ?? '';
    }
  }

  void _setLtdLng() {
    String? coordinate = widget.uri?.path;
    List<String>? coordinat = coordinate?.split(',');
    try {
      _location = MapCard.buildMarker(LatLng(double.parse(coordinat![0]), double.parse(coordinat[1])));
    } catch (e) {}

  }

  Future<void> _updateMap() async {
    final directions = await DirectionsRepository.getDirections(origin: widget.home.position, destination: _location!.position);
    // _latitudeController.text = _location!.position.latitude.toString();
    // _longitudeController.text = _location!.position.longitude.toString();
      // _mapKey.currentState!.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(target: res.latLng!, zoom: 13.5)));
    // double vpd = 0.000;
    _bounds = directions!.bounds;

    // LatLngBounds viewBounds = LatLngBounds(northeast: LatLng(lb.northeast.latitude + vpd, lb.northeast.longitude),southwest: LatLng(lb.southwest.latitude + vpd, lb.southwest.longitude));
      if (_controller != null)_controller!.animateCamera(CameraUpdate.newLatLngBounds(_bounds!, 30.0));
      _location = MapCard.buildMarker(_location!.position);
      _route = directions;
      _distance = double.tryParse(directions.totalDistance.split(' ')[0]);
      if (_distance != null) _ongkir = ((_tarifOngkirPerKm * _distance!)/1000).round() * 1000;
  }


  @override
  void initState() {

    // MapCard.getHomeMarker(context).then(
    //         (value) => _home = value);
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    _setLtdLng();
    _parseFromClipboard();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      Future.delayed(Duration(milliseconds: 500))
          .then((_) => _parseFromClipboard());
    }
  }

  @override
  Widget build(BuildContext context) {
    // _home = context.watch<FirebaseState>().home!;
    _tarifOngkirPerKm = context.watch<FirebaseState>().tarifOngkir!;

    print('Refresh');

    //TODO ngasih centang auto isi apa engga
    return Container(
      color: kPrimaryColor,
      child: SafeArea(
          child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            // color: Color(0xFFFFD7B2),
            color: Color.fromARGB(200, 215, 195, 218),
            // color: Colors.white,
            height: SizeConfig.screenHeight,
            child: Column(
              children: [
                TopContainer(
                  width: SizeConfig.screenWidth,
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Column(
                    children: [
                      MyBackButton(),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Tambah Pesanan',
                            style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 15,
                              child: _buildPesenanFormField(
                                'Barang',
                                controller: _barangController,
                                onSaved: (value) {
                                  _barang = value!;
                                  _barangId = value.toLowerCase();
                                },
                                onChanged: (value) {
                                  if (value.isNotEmpty)
                                    _removeError(
                                        error: kPesenanNullError,
                                        atController: 'barang');
                                },
                                validator: (value) {
                                  if (value!.isEmpty)
                                    _addError(
                                        error: kPesenanNullError,
                                        atController: 'barang');
                                },
                              ) //TODO check not null
                              ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              flex: 6,
                              child: _buildPesenanFormField('Jumlah',
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    if (int.tryParse(value) != null)
                                      _removeError(
                                          error: kPesenanIntError,
                                          atController: 'jumlah');
                                  },
                                  controller: _jumlahController,
                                  validator: (value) {
                                    if (value!.isEmpty) _addError(error: kPesenanNullError, atController: 'jumlah');
                                    if (int.tryParse(value) == null) _addError(error: kPesenanIntError, atController: 'jumlah');
                                  },
                                  onSaved: (value) => _jumlah =
                                      int.parse(value!)) //TODO check if int
                              )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: _buildPesenanFormField(
                            'Nama',
                            onChanged: (value) {
                              if (value.isNotEmpty)
                                _removeError(
                                    error: kPesenanNullError,
                                    atController: 'nama');
                            },
                            controller: _namaController,
                            validator: (value) {
                              if (value!.isEmpty) _addError(error: kPesenanNullError, atController: 'nama');
                            },
                            onSaved: (value) => _nama = value!,
                          )),
                      //TODO not nul
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          flex: 1,
                          child: _buildPesenanFormField('No. Wa',
                              keyboardType: TextInputType.number,
                              controller: _kontakController,
                              validator: (value) {
                                if (value!.isEmpty) _addError(error: kPesenanNullError, atController: 'kontak');
                              },
                              onChanged: (value) {
                                if (value.isNotEmpty)
                                  _removeError(
                                      error: kPesenanNullError,
                                      atController: 'kontak');
                              },
                              onSaved: (value) => _kontak = value!)),
                      //TODO not nullZ
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: _buildPesenanFormField(
                          'Alamat',
                          validator: (value) {
                            if (value!.isEmpty) _addError(error: kPesenanNullError, atController: 'alamat');
                          },
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              _removeError(
                                  error: kPesenanNullError,
                                  atController: 'alamat');
                              _alamatIsEmpty = false;
                            } else {
                              _alamatIsEmpty = true;
                            }
                          },
                          controller: _alamatController,
                          onSaved: (value) => _alamat = value!,
                        ), //TODO not nul
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          flex: 2,
                          child: _buildPesenanFormField(
                            'Harga',
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) _addError(error: kPesenanNullError, atController: 'harga');
                              if (int.tryParse(value) == null) _addError(error: kPesenanIntError, atController: 'harga');
                            },
                            onChanged: (value) {
                              if (value.isNotEmpty)
                                _removeError(
                                    error: kPesenanNullError,
                                    atController: 'harga');
                              if (int.tryParse(value) != null) {
                                _removeError(
                                    error: kPesenanIntError,
                                    atController: 'harga');
                              }
                            },
                            controller: _hargaController,
                            onSaved: (value) {
                              _harga = int.parse(value!);
                              _totalHarga = _harga + _ongkir!;
                            },
                          ))
                      //todo if int
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 25,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Lokasi:',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: FutureBuilder<void>(
                    future: _updateMap(),
                    builder: (context, snapshot) {
                return Column(
                  children: [
                    MapCard(
                      onMapCreated: (controller) {
                        _controller = controller;
                      },
                      height: getProportionateScreenHeight(200),
                    polylines: {
                    if (_route != null) Polyline(
                    polylineId: PolylineId('overview_polyline'),
                    color: Color.fromARGB(255, 232, 111, 139),
                    width: 5,
                    points: _route!.polylinePoints.map((e) => LatLng(e.latitude, e.longitude)).toList()
                    )
                    },
                    // key: _controller,
                    clickable: true,
                    markers: {
                    // MapCard.buildMarker(LatLng(-7.915397833847288,111.62983104586601)),
                    widget.home,
                    if (_location != null) _location!
                    },
                    onPicked: (res) {
                    if (_alamatIsEmpty) {
                      if (res.address != null) _alamatController.text = res.address!;
                      _alamatIsEmpty = false;
                    }
                    setState(() => _location = MapCard.buildMarker(res.latLng!));
                    // FocusScopeNode currentFocus = FocusScope.of(context);
                    // if (!currentFocus.hasPrimaryFocus) {
                    //   currentFocus.unfocus();
                    // }
                    },
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 25,
                      ),
                      child: Row(
                          mainAxisAlignment:MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                'Jarak: ${(_distance != null) ? '$_distance km' : ''}',
                                style: TextStyle(
                                    color: Colors.white, fontWeight: FontWeight.normal),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                  'Ongkir: ${_ongkir != null ? FirebaseState.asRupiah(_ongkir!) : ''}',
                                  style: TextStyle(
                                      color: Colors.white, fontWeight: FontWeight.normal
                                  )
                              ),
                            )
                          ]
                      ),
                    ),
                  ],
                );
                    }
                  )
                ),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 20),
                //   child: Row(
                //     children: [
                //       Expanded(
                //           flex: 4,
                //           child: _buildPesenanFormField(
                //             'Latitude',
                //             controller: _latitudeController,
                //             onSaved: (value) => _latitude = double.parse(value!),
                //             onChanged: (value) {
                //               if (value.isNotEmpty)
                //                 _removeError(
                //                     error: kPesenanNullError,
                //                     atController: 'latitude');
                //               if (double.tryParse(value) != null)
                //                 _removeError(
                //                     error: kPesenanDoubleError,
                //                     atController: 'latitude');
                //             },
                //             validator: (value) {
                //               if (value!.isEmpty) _addError(error: kPesenanNullError, atController: 'latitude');
                //               if (double.tryParse(value) == null) {
                //                 _addError(error: kPesenanDoubleError,atController: 'latitude');
                //               } else if (double.parse(value) < -180.0 || double.parse(value) > 180.0) _addError(error: kPesenanGeoError, atController: 'latitude');
                //             },
                //           )),
                //       //todo check doubl
                //       SizedBox(
                //         width: 20,
                //       ),
                //       Expanded(
                //         flex: 4,
                //         child: _buildPesenanFormField(
                //           'Longitude',
                //           controller: _longitudeController,
                //           onChanged: (value) {
                //             if (value.isNotEmpty)
                //               _removeError(
                //                   error: kPesenanNullError,
                //                   atController: 'longitude');
                //             if (double.tryParse(value) != null)
                //               _removeError(
                //                   error: kPesenanDoubleError,
                //                   atController: 'longitude');
                //           },
                //           validator: (value) {
                //             if (value!.isEmpty) _addError(error: kPesenanNullError, atController: 'longitude');
                //             if (double.tryParse(value) == null) {
                //               _addError(error: kPesenanDoubleError,atController: 'longitude');
                //             } else if (double.parse(value) < -180.0 || double.parse(value) > 180.0) _addError(error: kPesenanGeoError, atController: 'longitude');
                //           },
                //           onSaved: (value) => _longitude = double.parse(value!),
                //         ), //todo check double
                //       )
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Consumer<FirebaseState>(
                    builder: (context, value, child) {
                      DocumentReference orderReference =
                          FirebaseFirestore.instance.collection('orders').doc();
                      return DefaultButton(
                          text: 'Simpan',
                          press: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              orderReference.set({
                                'uid': value.uid,
                                'date_created': Timestamp.now(),
                                'order_status': 'active',
                                'nama_barang': _barang,
                                'barang_id': _barangId,
                                'kuantitas': _jumlah,
                                'harga': _harga,
                                'ongkir': _ongkir,
                                'total': _totalHarga,
                                'pembeli': {
                                  'nama': _nama,
                                  'alamat': _alamat,
                                  'jarak': _distance,
                                  'kontak': _kontak,
                                  'koordinat': GeoPoint(_location!.position.latitude, _location!.position.longitude),
                                  'bounds': {
                                    'northeast': GeoPoint(_bounds!.northeast.latitude, _bounds!.northeast.longitude),
                                    'southwest': GeoPoint(_bounds!.southwest.latitude, _bounds!.southwest.longitude, )
                                  },
                                  'polylines': _route!.polyline
                                }
                              });
                              value.updateSumPesenan(_totalHarga);
                              Navigator.pop(context);
                            }
                          });
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  TextFormField _buildPesenanFormField(String title,
      {Color color = Colors.white,
      TextEditingController? controller,
      void Function(String? value)? onSaved,
      void Function(String value)? onChanged,
      String? Function(String? value)? validator,
      TextInputType? keyboardType}) {
    return TextFormField(
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator,
      controller: controller,
      onSaved: onSaved,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: color),
          // gapPadding: 0,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: color),
          // gapPadding: 0,
        ),
        labelText: title,
        labelStyle: TextStyle(color: color),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // )
      ),
    );
  }
}
