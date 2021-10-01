
import 'package:fiksii/components/firebase_state.dart';
import 'package:fiksii/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Text(
            "Dashboard",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(20),
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ],
      ),
    );
  }
}

class DashboardAppBar extends StatelessWidget {
  DashboardAppBar({
    required this.onPressed,
    required this.colorAnimationController,
    required this.colorTween,
    required this.drawerTween,
    required this.iconTween,
    required this.homeTween,
    required this.workOutTween,
  });

  AnimationController colorAnimationController;
  Animation colorTween, homeTween, workOutTween, iconTween, drawerTween;
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80, //tODO
      child: AnimatedBuilder(
        animation: colorAnimationController,
        builder: (context, child) => AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.dehaze,
              color: drawerTween.value,
            ),
            onPressed: onPressed,
          ),
          backgroundColor: colorTween.value,
          elevation: 0,
          titleSpacing: 0.0,
          title: Consumer<FirebaseState>(
            builder: (context, value, child) {
              return Row(
                children: [
                  Text(
                    "Hello  ",
                    style: TextStyle(
                        color: homeTween.value,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        letterSpacing: 1),
                  ),
                  Text(
                    "${value.email}",
                    style: TextStyle(
                        color: workOutTween.value,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        letterSpacing: 1),
                  )
                ],
              )
              ;
            }
          ),
          actions: [
            Icon(
              Icons.notifications,
              color: iconTween.value,
            ),
            Padding(
              padding: EdgeInsets.all(7),
              child: CircleAvatar(
                backgroundImage: NetworkImage('image_url'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// class Pesenan {
//   Pesenan({
//     required this.nama,
//     required this.noWa,
//     required this.alamat,
//     required this.jenisBarang,
//     required this.jumlah,
//     required this.koordinat,
//
// });
//   String nama;
//   String noWa;
//   String alamat;
//   String jenisBarang;
//   String jumlah;
//   String koordinat;
//   String? harga;
//   String? ongkir;
//   String? totalHarga;
//
// }