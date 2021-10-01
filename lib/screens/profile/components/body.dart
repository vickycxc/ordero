import 'package:fiksii/components/firebase_state.dart';
import 'package:fiksii/screens/profile/components/profile_menu.dart';
import 'package:fiksii/screens/profile/components/profile_pic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  const Body({Key? key, required this.user}) : super(key: key);
  final FirebaseState user;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<FirebaseState>(
        builder: (context, value, child) {
          // value.init();
          return Column(
            children: [
              // Text((value.email != null) ? value.email! : ''),
              // TextButton(
              //     onPressed: () {
              //       value.signOut();
              //     },
              //     child: Text('Log Out')),
              Spacer(
                flex: 3,
              ),
              ProfilePic(),
              Spacer(
                flex: 3,
              ),
              ProfileMenu(
                icon: 'assets/icons/Parcel.svg',
                press: () {},
                text: 'Riwayat Pesanan',
              ),
              ProfileMenu(
                icon: 'assets/icons/Cart Icon.svg',
                press: () {},
                text: 'Katalog Toko',
              ),
              ProfileMenu(
                icon: 'assets/icons/User Icon.svg',
                press: () {},
                text: 'Akun Saya',
              ),
              ProfileMenu(
                icon: 'assets/icons/Gift Icon.svg',
                press: () {},
                text: 'Pembelian & Langganan',
              ),
              ProfileMenu(
                icon: 'assets/icons/Log out.svg',
                press: () {
                  value.signOut();
                },
                text: 'Keluar ',
              ),
              Spacer(
                flex: 4,
              )
            ],
          );
        },
      ),
    );
  }
}
