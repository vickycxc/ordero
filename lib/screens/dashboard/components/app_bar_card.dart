import 'package:fiksii/components/custom_suffix_icon.dart';
import 'package:fiksii/components/firebase_state.dart';
import 'package:fiksii/constants.dart';
import 'package:fiksii/screens/add_pesenan/add_pesenan_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppBarCard extends StatelessWidget {
  const AppBarCard({
    Key? key, required this.pesananAktif, required this.totalTransaksi, required this.home,
  }) : super(key: key);

  final int pesananAktif;
  final int totalTransaksi;
  final Marker home;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Color(0xFFECEAC5),
                  ),
                  padding: EdgeInsets.fromLTRB(14.0, 8.0, 8.0, 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pesanan Aktif',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 11),
                      ),
                      Text(
                        '$pesananAktif',
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Expanded(
                  flex: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Color(0xFFFFE9E6),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 6,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(14.0, 8.0, 8.0, 8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Total Transaksi',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 11),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          FirebaseState.asRupiah(totalTransaksi),
                                          style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        Expanded(
                          flex: 2,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                      child: Icon(Icons.add_circle, size: 30,color: kPrimaryTextColor,),
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddPesenanScreen(home: home),));
                                    },
                                  ),
                                  // SizedBox(width: 2,),
                                  GestureDetector(
                                    child: Container(height: 30,width: 30,child: CustomSuffixIcon(svgIcon: 'assets/icons/pos-terminal.svg',)),
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddPesenanScreen(home: home,),));
                                    },
                                  ),
                                ],
                              )),
                      ],
                    ),
                  )),
            ],
          ),
        ))
      ],
    );
  }
}
