import 'package:fiksii/components/custom_suffix_icon.dart';
import 'package:fiksii/components/default_button.dart';
import 'package:fiksii/components/firebase_state.dart';
import 'package:fiksii/components/form_error.dart';
import 'package:fiksii/screens/forgot_password/forgot_password_screen.dart';
import 'package:fiksii/screens/login_success/login_success_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
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
          children: [
            buildEmailFormField(),
            SizedBox(height: getProportionateScreenHeight(30),),
            buildPasswordFormField(),
            SizedBox(height: getProportionateScreenHeight(30),),
            Row(children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value!;
                  });
                },),
              Text("Remember me"),
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context,
                    ForgotPasswordScreen.routeName
                ),
                child: Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ],),
            FormError(errors: errors),
            SizedBox(height: getProportionateScreenHeight(20),),
            Consumer<FirebaseState>(
                builder: (context, value, child) {
                  return DefaultButton(
                    text: "Continue",
                    press: () async {
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
                    },
                  );
                },)
          ],
        )
    );
  }

  TextFormField buildPasswordFormField() {
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
        labelText: "Password",
        labelStyle: TextStyle(color: Color(0xFF8B8B8B)),
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/Lock.svg",
        ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
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
            labelText: "Email",
            labelStyle: TextStyle(color: Color(0xFF8B8B8B)),
            hintText: "Enter your email",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: CustomSuffixIcon(
              svgIcon: "assets/icons/Mail.svg",
            )
        )
    );
  }
}

