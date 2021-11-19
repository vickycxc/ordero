import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key? key,
    this.diameter = 115,
    this.withCamera = true

  }) : super(key: key);

  final double diameter;
  final bool withCamera;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: diameter,
      width: diameter,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/logo/orderly_logo.png'),
          ),
         if (withCamera) Positioned(
            right: -10,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Color(0xFFF5F6F9),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50), side: BorderSide(color: Colors.white))
                ),
                onPressed: () {},
                child: SvgPicture.asset('assets/icons/Camera Icon.svg'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
