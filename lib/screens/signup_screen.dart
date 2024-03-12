import 'package:boundless/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:boundless/utils/constants.dart';
import 'package:boundless/widgets/custom_btn.dart';
import 'package:firebase_database/firebase_database.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key});
  static const String id = 'signup_screen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final user = FirebaseAuth.instance.currentUser;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _saveDataToDatabase() async {
    final DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref("users/${user?.uid}");
    print(databaseReference.path);
    await databaseReference.set({
      'name': _nameController.text,
      'surname': _surnameController.text,
      'password': _passwordController.text,
      'phone': user?.phoneNumber,
    }).then((_) {
      Navigator.pushNamed(context, MainScreen.id);
      print('Data saved to Firebase');
    }).catchError((error) {
      print('Error saving data: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.mainColor,
      appBar: AppBar(
        title: Text("Sign up"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Enter your name",
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
                        controller: _nameController,
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
                "Enter your surname",
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
                        controller: _surnameController,
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
              const SizedBox(height: 50), // Added for spacing
              Center(
                child: BtnPrincipal(
                  text: "Sign Up",
                  onPressed: _saveDataToDatabase,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
