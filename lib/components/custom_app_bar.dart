import 'package:fiksii/constants.dart';
import 'package:fiksii/screens/dashboard/components/app_bar_card.dart';
import 'package:fiksii/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({Key? key, required this.pesananAktif, required this.totalTransaksi, required this.namaBisnis, required this.home}) : super(key: key);

  final int pesananAktif;
  final int totalTransaksi;
  final String namaBisnis;
  final Marker home;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      actions: [],
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            // child: Container(
            //   height: getProportionateScreenHeight(34),
            //   width: getProportionateScreenHeight(34),
            //   decoration:
            //       BoxDecoration(shape: BoxShape.circle,
            //           color: Colors.grey
            //       ),
            // ),
              child: Image.asset('assets/logo/ordero_logo_transparent.png', width: getProportionateScreenHeight(34),height: getProportionateScreenHeight(34),)
          ),
          // Spacer(),
          Text(namaBisnis,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: getProportionateScreenHeight(20),
                  letterSpacing: 1.5)),
          // Spacer(flex: 5),
        ],
      ),
      backgroundColor: kPrimaryColor,
      pinned: true,
      floating: true,
      expandedHeight: 150,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          // color: Colors.amber,
          color: Color.fromARGB(255, 182, 205, 252),
          height: getProportionateScreenHeight(300),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: SizedBox(),
              ),
              Expanded(
                flex: 4,
                child: AppBarCard(home: home, pesananAktif: pesananAktif, totalTransaksi: totalTransaksi,),
              ),
            ],
          ),
        ),
      ),
      // flexibleSpace: FlexibleSpaceBar(
      //   title: Text(
      //     'ORDERO',
      //     style: TextStyle(
      //       fontWeight: FontWeight.bold,
      //       fontSize: getProportionateScreenWidth(20.0)
      //     ),
      //   ),
      //   background: FlutterLogo(),
      // ),
      // actions: [
      //   IconButton(onPressed: () {},
      //     icon: const Icon(Icons.add_circle),
      //     tooltip: 'Add new entry',)
      // ],
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
