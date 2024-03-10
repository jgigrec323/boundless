import 'package:boundless/screens/login_screen.dart';
import 'package:boundless/screens/phone_auth.dart';
import 'package:boundless/screens/signup_screen.dart';
import 'package:boundless/utils/constants.dart';
import 'package:boundless/widgets/custom_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String id = 'home_screen';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.mainColor,
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                Constants.logoName,
                style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 50,
              ),
              BtnPrincipal(
                  text: "Log In",
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.id);
                  }),
              const SizedBox(
                height: 30,
              ),
              BtnPrincipal(
                  text: "Sign Up",
                  onPressed: () {
                    Navigator.pushNamed(context, PhoneAuth.id);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
