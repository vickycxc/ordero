import 'package:flutter/material.dart';

import '../../../size_config.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    required this.splashData,
  }) : super(key: key);

  final Map<String, String> splashData;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Stack(
          children: [
            Image.asset(splashData['image']!,fit: BoxFit.cover,
              height: SizeConfig.screenHeight,
              width: SizeConfig.screenWidth,),
            Column(
              children: [
                Expanded(child: Container()),
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black,
                            Colors.transparent
                          ],
                          stops: [0.2, 1]
                      )
                  ),
                  width: SizeConfig.screenWidth,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.03, vertical: SizeConfig.screenHeight * 0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(alignment: AlignmentDirectional.bottomStart,child: Text(splashData['title']!,style: TextStyle(fontSize: 40,color: Colors.white, fontWeight: FontWeight.w700,fontFamily: 'League Spartan'),)),
                        // SizedBox(height: SizeConfig.screenHeight * 0.1)
                        SizedBox(height: SizeConfig.screenHeight * 0.01,),
                        Row(
                          children: [
                            Expanded(child: Text(splashData['subtitle']!, style: TextStyle(fontSize: 12,color: Colors.white, fontWeight: FontWeight.w300,fontFamily: 'Nexa'),),flex: 4,),
                            Expanded(child: Container(),)
                          ],
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.05,),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
