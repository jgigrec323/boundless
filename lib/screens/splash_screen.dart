import 'package:boundless/screens/home_screen.dart';
import 'package:boundless/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  static const String id = 'splash_screen';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: EasySplashScreen(
        logo: Image.asset('assets/images/logo.png'),
        logoWidth: 120,
        backgroundColor: Constants.mainColor,
        navigator: const HomeScreen(),
        durationInSeconds: 3,
        showLoader: false,
      ),
    );
  }
}
