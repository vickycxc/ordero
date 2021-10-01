import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiksii/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import 'map_card.dart';
import 'order_format.dart';

class FirebaseState extends ChangeNotifier {

  FirebaseState() {
    Firebase.initializeApp().then((value) {
      FirebaseFirestore.instance;
      FirebaseAuth.instance.userChanges().listen((user) async {
        print('loop');
        if (user != null) {
          updateLoginState();
          _userDoc = FirebaseFirestore.instance.doc('users/$_uid');
          DocumentSnapshot userInfo = await _userDoc!.get();
          if (userInfo.exists) {
            Map<String, dynamic> user = userInfo.data() as Map<String, dynamic>;
            if (user['complete_profile'] == false) {
              _completeProfile = false;
            } else {
              _completeProfile = true;
              GeoPoint home = user['lokasi_bisnis'];
              _home = await MapCard.getHomeMarker(LatLng(home.latitude, home.longitude));
              _tarifOngkir = user['tarif_ongkir'];
              _namaBisnis = user['nama_bisnis'];
              _keuangan = Keuangan.fromMap(user['keuangan']);
            }
          }
          _loginState = LoginState.loggedIn;
        } else {
          _loginState = LoginState.loggedOut;
          updateLoginState();
        }
        notifyListeners();
      });
    });
  }
  //
  // Future<void> init() async {
  // }


  LoginState? _loginState;
  LoginState? get loginState => _loginState;

  DocumentReference? _userDoc;
  DocumentReference? get userDoc => _userDoc;

  User? _user;
  User? get user => _user;

  String? _email;
  String? get email => _email;

  String? _uid;
  String? get uid => _uid;

  String? _namaBisnis;
  String? get namaBisnis => _namaBisnis;

  int? _tarifOngkir;
  int? get tarifOngkir => _tarifOngkir;

  // int? _totalPendapatan;
  // int? get totalPendapatan => _totalPendapatan;
  //
  // int? _totalPembelian;
  // int? get totalPembelian => _totalPembelian;

  Keuangan? _keuangan;
  Keuangan? get keuangan => _keuangan;

  bool? _completeProfile;
  bool? get completeProfile => _completeProfile;

  Marker? _home;
  Marker? get home => _home;

  KeuanganPerBulan? _cache;
  KeuanganPerBulan? get cache => cache;

  void updateCache(KeuanganPerBulan? cache) {
    _cache = cache;
  }

  Future<bool> completeRegistration(
      // Image profile,
      String namaPengguna,
      String namaBisnis,
      String kategoriBisnis,
      Marker lokasiBisnis,
      String alamatBisnis,
      int tarifOngkir,
      BuildContext context) async {
    try {
      _keuangan = Keuangan(
          totalPenjualan: 0,
          totalPendapatan: 0
      );
      _userDoc!.update({
        'complete_profile': true,
        'nama_pengguna': namaPengguna,
        'nama_bisnis': namaBisnis,
        'kategori_bisnis': kategoriBisnis,
        'lokasi_bisnis': GeoPoint(lokasiBisnis.position.latitude, lokasiBisnis.position.longitude),
        'tarif_ongkir': tarifOngkir,
        'keuangan': {
          'total_pendapatan': _keuangan!.totalPendapatan,
          'total_pembelian': _keuangan!.totalPenjualan,
        }
      });
      _completeProfile = true;
      _home = await MapCard.getHomeMarker(lokasiBisnis.position);
      _tarifOngkir = tarifOngkir;
      _namaBisnis = namaBisnis;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch(e) {
      showErrorDialog(context, 'Error', e);
      return false;
    }
  }

  Future<bool> register(
      String email,
      String password,
      BuildContext context
      ) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      updateLoginState();
      _userDoc!.set({
        'date_created': Timestamp.now(),
        'complete_profile': false,
        'login_method': 'email',
        'email': _user!.email,
      });
      return true;
    } on FirebaseAuthException catch (e) {
      showErrorDialog(context, 'Error', e);
      return false;
    }
  }

  static void showErrorDialog(BuildContext context, String title, Exception e) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title:  Text(
            title,
            style: const TextStyle(fontSize: 24),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('${(e as dynamic).message}',
                style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () {
              Navigator.of(context).pop();
            }, child: const Text(
              'OK',
              style: TextStyle(
                color: Colors.deepPurple
              ),
            ))
          ],
        );
      },
    );
  }

  Future<bool> login(String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      notifyListeners();
      return true;

    } on FirebaseAuthException catch (e) {
      FirebaseState.showErrorDialog(context, 'Error', e);
      notifyListeners();
      return false;
    }
  }

  void updateSumPesenan(int totalHarga) {
    _keuangan!.totalPendapatan = _keuangan!.totalPendapatan+ totalHarga;
    _keuangan!.totalPenjualan = _keuangan!.totalPenjualan +1;
    _userDoc!.update({
      'keuangan': {
        'total_pendapatan': _keuangan!.totalPendapatan,
        'total_pembelian': _keuangan!.totalPenjualan
      }
    });
  }
  //
  // void updateUserPesenanData(String id, String harga,)

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  void updateLoginState() {
    _user = FirebaseAuth.instance.currentUser;
    _email = user?.email;
    _uid = user?.uid;
  }

  Future<KeuanganPerBulan> getKeuanganBulanIni() async {
    DateTime now = DateTime.now();
    DateTime minusOneMonth = now.subtract(Duration(days: 30));
    Timestamp oneMonthBefore = Timestamp.fromDate(minusOneMonth);
    final fs = await  FirebaseFirestore
        .instance.collection('/orders')
    .where('uid', isEqualTo: user!.uid)
    .where('date_created', isGreaterThanOrEqualTo: oneMonthBefore)
        .get();
    int pendapatan = 0;
    int penjualan = fs.docs.length;
    fs.docs.forEach((element) {
      Map<String, dynamic> map = element.data();
      var ord = OrderFormat.fromMap(map, element.id);
      pendapatan += ord.total;
    });
    return KeuanganPerBulan(penjualanPerBulan: penjualan,pendapatanPerBulan: pendapatan);
  }

  /*Stream<KeuanganPerBulan> keuanganBulanIni() async* {
    DateTime now = DateTime.now();
    DateTime minusOneMonth = now.subtract(Duration(days: 30));
    Timestamp oneMonthBefore = Timestamp.fromDate(minusOneMonth);
    Stream<QuerySnapshot> _stream = FirebaseFirestore.instance
        .collection('/orders')
        .orderBy('date_created', descending: true)
        .where('order_status', isEqualTo: 'active')
        // .where('date_created', isGreaterThanOrEqualTo: oneMonthBefore)
        .snapshots();

    _stream.listen((event) async* {
      int pendapatan = 0;
      int pembelian = event.size;

      event.docs.forEach((order) {
        if (order.exists) {
          Map<String, dynamic> data = order.data() as Map<String, dynamic>;
          OrderFormat ord = OrderFormat.fromMap(data, order.id);
          pendapatan += ord.total;
        }
      });
      yield KeuanganPerBulan(penjualanPerBulan: pembelian, pendapatanPerBulan: pendapatan);
    });
  }*/

  static List<OrderFormat> toListOrderFormat(List<QueryDocumentSnapshot> snapshots) {
    List<OrderFormat> ord = [];
    snapshots.forEach((snap) {
      Map<String, dynamic> data =
      snap.data() as Map<String, dynamic>;
      OrderFormat pdr = OrderFormat.fromMap(data, snap.id);
      ord.add(pdr);
    });
    return ord;
  }


  static String asRupiah(int uang) {
    return NumberFormat.currency(locale: 'id', symbol: 'Rp. ', decimalDigits: 0).format(uang);
  }

  static String formatDate(DateTime timestamp) {
    return DateFormat('d MMM y, k:m', 'id_ID').format(timestamp);
  }
// String _email;
  // String get email => _email;
}
