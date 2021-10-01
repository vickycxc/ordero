import 'package:fiksii/components/default_button.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 22),
              child: Row(
                children: [
                  Icon(Icons.shopping_cart, size: 30,),
                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Skincare', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                      Text('Rp. 29.000 x 2'),
                    ],
                  ),
                  Expanded(child: Container(),),
                  Text('Rp. 58.000', style: TextStyle(fontSize: 20,),),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 22),
              child: Row(
                children: [
                  Icon(Icons.shopping_cart, size: 30,),
                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Roti', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                      Text('Rp. 5.000 x 3'),
                    ],
                  ),
                  Expanded(child: Container(),),
                  Text('Rp. 15.000', style: TextStyle(fontSize: 20,),),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 22),
              child: Row(
                children: [
                  Icon(Icons.shopping_cart, size: 30,),
                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Buku', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                      Text('Rp. 14.000 x 5'),
                    ],
                  ),
                  Expanded(child: Container(),),
                  Text('Rp. 70.000', style: TextStyle(fontSize: 20,),),
                ],
              ),
            ),
          ],
        ),

        Container(
          color: Colors.black12,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [

                // SizedBox(width: 12.0),
                Expanded(child: Container(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total:', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
                    Text('Rp.143.000', style: TextStyle(fontSize: 18),)
                  ],
                ))),
                Expanded(child: DefaultButton(text: 'Cetak Struk', press: () {},)),
                // SizedBox(width: 12,)
              ],
            ),
          ),
        )
      ],
    );
  }
}
