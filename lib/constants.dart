import 'package:fiksii/size_config.dart';
import 'package:flutter/material.dart';

// const kPrimaryColor = Color(0xFFFF7643);
// const kPrimaryLightColor = Color(0xFFFFECDF);
// const kPrimaryGradientColor = LinearGradient(begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//     colors: [Color(0xFFFFa53E), Color(0xFFFF7643)]);
// const kSecondaryColor = Color(0xFF979797);
// const kTextColor = Color(0xFF757575);

// // const kPrimaryColor = Color(0xFFFF9100);
// const kPrimaryColor = Color.fromARGB(255, 173, 152, 220);
// // const kPrimaryGradient = Colir.
// // const kPrimaryColor = Colors.amber;
const kPrimaryLightColor = Color(0xFFFFC246);
const kPrimaryDarkColor = Color(0xFFC56200);
// const kPrimaryTextColor = Color(0xFF757575);
const kPrimaryTextColor = Colors.white70;
//from instagram
const kColorOne = Color(0xFF125488);
const kColorTwo = Color(0xFF2A93D5);
const kColorThree = Color(0xFF37CAEC);
const kColorFour = Color(0xFF3DD9D6);
const kColorFive = Color(0xFFADD9D8);

const kPrimaryColor = kColorTwo;

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
    fontSize: getProportionateScreenWidth(28),
    fontWeight: FontWeight.bold,
    color: Colors.black,
    height: 1.5,
);

//Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[zA-z0-9.]+@[a-zA-z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter valid email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Password don't Match";
const kNameNullError = "Please Enter your name";
const kPhoneNumberNullError = "Please Enter your phone number";
const kAdressNullError = "Please Enter your adress";

const String kPesenanNullError = 'Dilengkapin, Yuk :D';
const String kPesenanDoubleError = 'Diisi dalam bentuk angka yaa :)';
const String kPesenanGeoError = 'Koordinat tidak valid :o';
const String kPesenanIntError = 'Nilai harus merupakan bilangan asli ;)';

final otpInputDecoration = InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
    enabledBorder: outlineInputBorder(),
    focusedBorder: outlineInputBorder(),
    border: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: kPrimaryTextColor)
  );
}

enum LoginState {
    loggedOut,
    loggedIn,
}
