import 'package:boundless/screens/home_screen.dart';
import 'package:boundless/screens/login_screen.dart';
import 'package:boundless/screens/main_screen.dart';
import 'package:boundless/screens/phone_auth.dart';
import 'package:boundless/screens/signup_screen.dart';
import 'package:boundless/screens/splash_screen.dart';
import 'package:boundless/utils/constants.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Boundless",
      theme: ThemeData(
        primaryColor: Constants.mainColor,
        fontFamily: "Roboto",
        appBarTheme: const AppBarTheme(
          backgroundColor: Constants.blackColor,
        ),
      ),
      initialRoute: MainScreen.id,
      routes: {
        SplashScreen.id: (context) => const SplashScreen(),
        HomeScreen.id: (context) => const HomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        PhoneAuth.id: (context) => const PhoneAuth(),
        SignUpScreen.id: (context) => const SignUpScreen(),
        MainScreen.id: (context) => const MainScreen(),
      },
    );
  }
}
