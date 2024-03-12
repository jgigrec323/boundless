import 'package:boundless/screens/main_screen.dart';
import 'package:boundless/utils/constants.dart';
import 'package:boundless/widgets/custom_btn.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _phoneNumberController =
        TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Constants.mainColor,
      appBar: AppBar(
        title: Text("Log In"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 150, left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Enter your phone number",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                color: Constants.whiteColor,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _phoneNumberController,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(fontSize: 21),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 20.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),

              const Text(
                "Enter your password",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                color: Constants.whiteColor,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _passwordController,
                        keyboardType: TextInputType.multiline,
                        style: const TextStyle(fontSize: 21),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 20.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Forgot your password?",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(height: 50), // Added for spacing
              Center(
                child: BtnPrincipal(
                    text: "Log In",
                    onPressed: () {
                      //Navigator.pushNamed(context, MainScreen.id);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
