import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiksii/components/firebase_state.dart';
import 'package:fiksii/components/order_format.dart';
import 'package:fiksii/constants.dart';
import 'package:fiksii/screens/add_pesenan/add_pesenan_screen.dart';
import 'package:fiksii/screens/dashboard/dashboard_screen.dart';
import 'package:fiksii/screens/finance_chart/finance_chart_screen.dart';
import 'package:fiksii/screens/map_view/map_view_screen.dart';
import 'package:fiksii/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

// final List _screens = [
//   DashboardScreen(),
//   MapViewScreen(),
//   FinanceChartScreen(),
//   ProfileScreen()
// ];

Widget setScreen(int index, List<OrderFormat> orders, FirebaseState user) {
  switch (index) {
    case 0: return DashboardScreen(orders: orders, user: user,);
    case 1: return MapViewScreen(orders: orders, home: user.home!,);
    case 2: return FinanceChartScreen(user: user,);
    case 3: return ProfileScreen(user: user,);
  }
  return Center(
  child: Text('Error no screen')
  );
}

int _currentIndex = 0;
class _MainScreenState extends State<MainScreen> {
  // Uri? _sharedText;
  QuerySnapshot<Object?>? cacheObject;


  @override
  void initState() {
    // For sharing or opening urls/text coming from outside the app while the app is in the memory
    ReceiveSharingIntent.getTextStreamAsUri().listen((value) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => AddPesenanScreen(uri: value,home: Provider.of<FirebaseState>(context).home!),));
    }, onError: (err) {
      print('getLinkStream error: $err');//TODO tambahkan snackbar
    });

    // For sharing or opening urls/text coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialTextAsUri().then((value) async => {
      if (value != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddPesenanScreen(uri: value,home: Provider.of<FirebaseState>(context).home!),))
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<FirebaseState>(
        builder: (context, value, child) {
          if (value.loginState == LoginState.loggedOut) _currentIndex = 0;
          Stream<QuerySnapshot> _stream = FirebaseFirestore.instance
              .collection('/orders')
              .orderBy('date_created', descending: true)
              .where('uid', isEqualTo: value.uid)
              .where('order_status', isEqualTo: 'active')
              .snapshots();

          return StreamBuilder<QuerySnapshot>(
            initialData: cacheObject,
            stream: _stream,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting && snapshot.data == null) {
                return Center(child: Text('Loading'));
              }
              List<OrderFormat> orders = toListOrderFormat(snapshot.data!.docs);
              cacheObject = snapshot.data;
              return setScreen(_currentIndex, orders, value);
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          if (_currentIndex != value) setState(() => _currentIndex = value);
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        elevation: 0.0,
        currentIndex: _currentIndex,
        items: [Icons.home, Icons.map, Icons.event_note, Icons.info]
            .asMap()
            .map((key, value) => MapEntry(
                key,
                BottomNavigationBarItem(
                    label: '',
                    icon: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: (_currentIndex == key)
                            ? kPrimaryColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Icon(value),
                    ))))
            .values
            .toList(),
      ),
    );
  }
  List<OrderFormat> toListOrderFormat(List<QueryDocumentSnapshot> snapshots) {
    List<OrderFormat> ord = [];
    snapshots.forEach((snap) {
      Map<String, dynamic> data =
      snap.data() as Map<String, dynamic>;
      OrderFormat pdr = OrderFormat.fromMap(data, snap.id);
      ord.add(pdr);
    });
    return ord;
  }
}
