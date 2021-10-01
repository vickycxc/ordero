import 'package:fiksii/components/firebase_state.dart';
import 'package:fiksii/components/order_format.dart';
import 'package:fiksii/size_config.dart';
import 'package:flutter/material.dart';

class Stats extends StatelessWidget {
  const Stats({Key? key, required this.user}) : super(key: key);
  final FirebaseState user;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (SizeConfig.screenHeight * 0.35),
      child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Flexible(
                child: FutureBuilder<KeuanganPerBulan>(
                  future: user.getKeuanganBulanIni(),
                  builder: (context, snapshot) {
                    user.updateCache(snapshot.data);
                    return Row(
                      children: [
                        _buildStatCard(
                            'Penjualan sebulan terakhir', snapshot.data != null ? snapshot.data!.penjualanPerBulan.toString() : '', Colors.lightBlue),
                        _buildStatCard(
                            'Pendapatan sebulan terakhir', snapshot.data != null ? '${FirebaseState
                            .asRupiah(snapshot.data!.pendapatanPerBulan)}' : '',
                            Colors.lightGreen)
                      ],
                    );
                  }
                )),
            Expanded(
                child: Row(
              children: [
                _buildStatCard('Total Penjualan', '${user.keuangan!.totalPenjualan}', Colors.blue),
                _buildStatCard(
                    'Total Pendapatan', '${FirebaseState.asRupiah(user.keuangan!.totalPendapatan)}', Colors.green)
              ],
            )),
          ],
        ));
  }

  Expanded _buildStatCard(String title, String count, MaterialColor color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15.0)),
            Text(count,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0)),
          ],
        ),
      ),
    );
  }
}
