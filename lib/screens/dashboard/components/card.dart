import 'package:fiksii/components/firebase_state.dart';
import 'package:fiksii/components/order_format.dart';
import 'package:fiksii/screens/details/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PesenanRow extends StatelessWidget {
  const PesenanRow({required this.pesenan, required this.home});

  final OrderFormat pesenan;
  final Marker home;

  @override
  Widget build(BuildContext context) {

    final pesenanCardContent = Container(
      margin: EdgeInsets.all(12.0),
      constraints: BoxConstraints.expand(),
      child: Container(
        height: 4.0,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          //  Image.asset('assets/img/pill.png', height: 30.0),
                          //  Container(width: 5.0),
                          Text(pesenan.namaBarang,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                        ],
                      ),
                      Container(height: 5.0),
                      Text(pesenan.pembeli.nama, overflow: TextOverflow.ellipsis),
                      Container(height: 5.0),
                      Text(pesenan.pembeli.alamat, overflow: TextOverflow.ellipsis,),
                      Container(height: 5.0),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    // mainAxisAlignment: MainAxisAlignment.end
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(width: 5.0),
                          Text(
                            '${pesenan.kuantitas} Pcs',overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                      Container(height: 5.0),
                      Text(FirebaseState.asRupiah(pesenan.harga),
                          style: TextStyle(fontSize: 11),
                          overflow: TextOverflow.ellipsis),
                      Container(height: 5.0),
                      Text('${pesenan.pembeli.jarak} km', overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Ongkir: ${FirebaseState.asRupiah(pesenan.ongkir)}'),
                Text(
                  'Total: ${FirebaseState.asRupiah(pesenan.total)}',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    final pesenanCard = Container(
      child: Stack(
        children: [
          pesenanCardContent,
          ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(orderFormat: pesenan, home: home,),));
              },
              child: Container(width: double.infinity, height: double.infinity,),
              style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith((states) => Colors.black12)
              ),
            ),
          )
        ],
      ),
      height: 140.0,
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
    );

    return Container(
      height: 140.0,
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          pesenanCard,
        ],
      ),
    );
  }
}
