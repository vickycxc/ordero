import 'package:fiksii/components/custom_suffix_icon.dart';
import 'package:fiksii/components/default_button.dart';
import 'package:fiksii/components/firebase_state.dart';
import 'package:fiksii/components/form_error.dart';
import 'package:fiksii/constants.dart';
import 'package:fiksii/screens/login_success/login_success_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:provider/provider.dart';

import '../../../size_config.dart';

class SignForm extends StatefulWidget {
  const SignForm({
    Key? key,
    required this.outlineInputBorder,
  }) : super(key: key);

  final OutlineInputBorder outlineInputBorder;

  @override
  State<SignForm> createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GlassmorphicContainer(
            height: getProportionateScreenWidth(SizeConfig.screenWidth * 0.4),
            width: getProportionateScreenWidth(SizeConfig.screenWidth * 0.4),
            // padding: EdgeInsets.all(8),
            borderGradient: LinearGradient(colors: [
              Colors.white.withOpacity(0.1),
              Colors.white.withOpacity(0.05),
            ]),
            blur: 2,
            border: 4,
            borderRadius: 200,
            linearGradient: LinearGradient(colors: [
              Colors.white.withOpacity(0.1),
              Colors.white.withOpacity(0.05),
            ],
            stops: [0.5, 0.9],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset('assets/logo/ordero_logo_transparent.png'),
              ),
              ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          Text('Sign In',style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w800,
              fontSize: getProportionateScreenWidth(28),
              color: Colors.white.withOpacity(0.6)),),
          SizedBox(
            height: getProportionateScreenHeight(40),
          ),
          _buildEmailFormField(),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          _buildPasswordFormField(),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          FormError(errors: errors),
          SizedBox(
            height: getProportionateScreenHeight(10),
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
      decoration: InputDecoration(
        hintText: 'Email',
        hintStyle: TextStyle(
            color: Colors.white24,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold),
        prefixIcon: CustomSuffixIcon(
          color: Colors.white38,
          svgIcon: 'assets/icons/Mail.svg',
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.3),
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 0,
        ),

        enabledBorder: widget.outlineInputBorder,
        focusedBorder: widget.outlineInputBorder,
        border: widget.outlineInputBorder,
      ),
    );
  }

  TextFormField _buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
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
      decoration: InputDecoration(
        hintText: 'Password',
        hintStyle: TextStyle(
            color: Colors.white24,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold),
        prefixIcon: CustomSuffixIcon(
          color: Colors.white38,
          svgIcon: 'assets/icons/Lock.svg',
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.3),
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 0,
        ),

        enabledBorder: widget.outlineInputBorder,
        focusedBorder: widget.outlineInputBorder,
        border: widget.outlineInputBorder,
      ),
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
