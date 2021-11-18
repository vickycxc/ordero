// import 'package:fiksii/components/custom_suffix_icon.dart';
// import 'package:fiksii/components/default_button.dart';
// import 'package:fiksii/components/firebase_state.dart';
// import 'package:fiksii/components/form_error.dart';
// import 'package:fiksii/screens/complete_profile/complete_profile_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../../constants.dart';
// import '../../../size_config.dart';
//
// class SignUpForm extends StatefulWidget {
//   const SignUpForm({Key? key}) : super(key: key);
//
//   @override
//   _SignUpFormState createState() => _SignUpFormState();
// }
//
// class _SignUpFormState extends State<SignUpForm> {
//   final _formKey = GlobalKey<FormState>();
//   String? email;
//   String? password;
//   String? confirmPassword;
//   final List<String> errors = [];
//
//   void addError({required String error}) {
//     if (!errors.contains(error))
//     setState(() {
//       errors.add(error);
//     });
//   }
//
//   void removeError({required String error}) {
//     if (errors.contains(error))
//       setState(() {
//         errors.remove(error);
//       });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           buildEmailFormField(),
//           SizedBox(
//             height: getProportionateScreenHeight(30),
//           ),
//           buildPasswordFormField(),
//           SizedBox(
//             height: getProportionateScreenHeight(30),
//           ),
//           buildConfPasswordFormField(),
//           FormError(errors: errors),
//           SizedBox(
//             height: getProportionateScreenHeight(40),
//           ),
//           Consumer<FirebaseState>(
//             builder: (context, value, child) {
//               return DefaultButton(
//                   text: "Continue",
//                   press: () async {
//                     if (_formKey.currentState!.validate()) {
//                       _formKey.currentState!.save();
//                       bool registerSuccess = await value.register(email!, password!, context);
//                       if (registerSuccess) {
//                         Navigator.popAndPushNamed(
//                             context, CompleteProfileScreen.routeName);
//                       }
//                     }
//                   });
//             }
//           ),
//         ],
//       ),
//     );
//   }
//
//   TextFormField buildConfPasswordFormField() {
//     return TextFormField(
//       obscureText: true,
//       onSaved: (newValue) => confirmPassword = newValue,
//       onChanged: (value) {
//         if (password == confirmPassword) {
//           removeError(error: kMatchPassError);
//         } else if (value.length >= 8) {
//           removeError(error: kShortPassError);
//         }
//         return null;
//       },
//       validator: (value) {
//         if (value!.isEmpty) {
//           return "";
//         } else if (password != value) {
//           addError(error: kMatchPassError);
//           return "";
//         }
//         return null;
//       },
//       decoration: InputDecoration(
//         labelText: "Confirm Password",
//         labelStyle: TextStyle(color: Color(0xFF8B8B8B)),
//         hintText: "Re-enter your password",
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         suffixIcon: CustomSuffixIcon(
//           svgIcon: "assets/icons/Lock.svg",
//         ),
//       ),
//     );
//   }
//
//   TextFormField buildPasswordFormField() {
//     return TextFormField(
//       obscureText: true,
//       onSaved: (newValue) => password = newValue,
//       onChanged: (value) {
//         if (value.isNotEmpty) {
//           removeError(error: kPassNullError);
//         } else if (value.length >= 8) {
//           removeError(error: kShortPassError);
//         }
//         password = value;
//         return null;
//       },
//       validator: (value) {
//         if (value!.isEmpty) {
//           addError(error: kPassNullError);
//           return "";
//         } else if (value.length < 8) {
//           addError(error: kShortPassError);
//           return "";
//         }
//         return null;
//       },
//       decoration: InputDecoration(
//         labelText: "Password",
//         labelStyle: TextStyle(color: Color(0xFF8B8B8B)),
//         hintText: "Enter your password",
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         suffixIcon: CustomSuffixIcon(
//           svgIcon: "assets/icons/Lock.svg",
//         ),
//       ),
//     );
//   }
//
//   TextFormField buildEmailFormField() {
//     return TextFormField(
//         keyboardType: TextInputType.emailAddress,
//         onSaved: (newValue) => email = newValue!,
//         onChanged: (value) {
//           if (value.isNotEmpty) {
//             removeError(error: kEmailNullError);
//           } else if (emailValidatorRegExp.hasMatch(value)) {
//             removeError(error: kInvalidEmailError);
//           }
//           return null;
//         },
//         validator: (value) {
//           if (value!.isEmpty) {
//             addError(error: kEmailNullError);
//             return "";
//           } else if (!emailValidatorRegExp.hasMatch(value)) {
//             addError(error: kInvalidEmailError);
//             return "";
//           }
//           return null;
//         },
//         decoration: InputDecoration(
//             labelText: "Email",
//             labelStyle: TextStyle(color: Color(0xFF8B8B8B)),
//             hintText: "Enter your email",
//             floatingLabelBehavior: FloatingLabelBehavior.always,
//             suffixIcon: CustomSuffixIcon(
//               svgIcon: "assets/icons/Mail.svg",
//             )));
//   }
// }

import 'package:fiksii/components/custom_suffix_icon.dart';
import 'package:fiksii/components/firebase_state.dart';
import 'package:fiksii/components/form_error.dart';
import 'package:fiksii/constants.dart';
import 'package:fiksii/screens/login_success/login_success_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../size_config.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool remember = false;
  final List<String> errors = [];

  void addError({required String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }
  void removeError({required String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildEmailFormField(),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          _buildPasswordFormField(),
          SizedBox(
            height: getProportionateScreenHeight(0),
          ),
          FormError(errors: errors),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          Consumer<FirebaseState>(
              builder: (context, value, child) {
                return LoginButton(press: ()async{
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    bool loginSuccess = await value.login(
                        email!,
                        password!,
                        context
                    );
                    if (loginSuccess) {
                      Navigator.popAndPushNamed(
                          context, LoginSuccessScreen.routeName);
                    }
                  }
                },);
              }
          )
        ],
      ),
    );
  }
  TextFormField _buildEmailFormField() {
    return TextFormField(
        keyboardType: TextInputType.emailAddress,
        onSaved: (newValue) => email = newValue!,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kEmailNullError);
          } else if (emailValidatorRegExp.hasMatch(value)) {
            removeError(error: kInvalidEmailError);
          }
          return null;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kEmailNullError);
            return "";
          } else if (!emailValidatorRegExp.hasMatch(value)) {
            addError(error: kInvalidEmailError);
            return "";
          }
          return null;
        },
        decoration: loginStyle('Email', 'assets/icons/Mail.svg')
    );
  }

  TextFormField _buildPasswordFormField() {
    return TextFormField(
        obscureText: true,

        keyboardType: TextInputType.text,
        onSaved: (newValue) => password = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kPassNullError);
          } else if (value.length >= 8) {
            removeError(error: kShortPassError);
          }
          return null;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kPassNullError);
            return "";
          } else if (value.length < 8) {
            addError(error: kShortPassError);
            return "";
          }
          return null;
        },
        decoration: loginStyle('Password', 'assets/icons/Lock.svg')
    );
  }
  InputDecoration loginStyle(String hint, String icon) {
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.transparent),
      gapPadding: 10,
    );
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
          color: Colors.white24,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold),
      prefixIcon: CustomSuffixIcon(
        color: Colors.white38,
        svgIcon: icon,
      ),
      filled: true,
      fillColor: Colors.white.withOpacity(0.3),
      // floatingLabelBehavior: FloatingLabelBehavior.always,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 0,
      ),

      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      border: outlineInputBorder,
    );
  }
}

class LoginButton extends StatelessWidget {
  final VoidCallback press;
  const LoginButton({
    Key? key,
    required this.press
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: getProportionateScreenHeight(56),
        width: double.infinity,
        child: TextButton(
          style: TextButton.styleFrom(
              backgroundColor: Colors.white54,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          onPressed: press,
          child: Text(
            'Login',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: getProportionateScreenWidth(18),
                color: Colors.black26),
          ),
        ));
  }
}
