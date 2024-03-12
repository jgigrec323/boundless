import 'dart:async';

import 'package:boundless/screens/signup_screen.dart';
import 'package:boundless/utils/constants.dart';
import 'package:boundless/widgets/custom_btn.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OtpConfirmationScreen extends StatefulWidget {
  const OtpConfirmationScreen({Key? key, required this.phoneNumber})
      : super(key: key);
  final String phoneNumber;
  static const String id = 'otp';

  @override
  State<OtpConfirmationScreen> createState() => _OtpConfirmationScreenState();
}

class _OtpConfirmationScreenState extends State<OtpConfirmationScreen> {
  TextEditingController otpController = TextEditingController();
  int _timerCountdown = 60;
  Timer? _timer;
  bool _isOtpCompleted = false;
  String _verificationId = '';
  bool _isCorrect = false;
  String otpVal = "";
  final Duration oneSec = const Duration(seconds: 1);
  String type = "signup";

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    startTimer();
    _verifyPhoneNumber();
    // TODO: implement initState
    super.initState();
  }

  void resetTimer() {
    setState(() {
      _timerCountdown = 60;
    });
    startTimer();
  }

  void resendOtp() {
    // logic to resend OTP
    _verifyPhoneNumber();
    resetTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(
      oneSec,
      (timer) {
        setState(() {
          if (_timerCountdown < 1) {
            timer.cancel();
          } else {
            _timerCountdown--;
          }
        });
      },
    );
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _verifyPhoneNumber() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.verifyPhoneNumber(
      phoneNumber: widget.phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        _showSnackbar("Verification failed: ${e.message}");
      },
      codeSent: (String verificationId, int? resendToken) {
        _showSnackbar("Verification code sent to your phone");
        _verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      timeout: const Duration(seconds: 60),
    );
  }

  void _submitOtp(String otp) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: otp,
    );
    try {
      await auth.signInWithCredential(credential).then((value) async {
        setState(() {
          _isCorrect = true;
        });

        if (_isCorrect) {
          Navigator.pushNamed(context, SignUpScreen.id);
        }
      });
    } on FirebaseAuthException catch (e) {
      _showSnackbar("Verification failed: ${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.mainColor,
      appBar: AppBar(
        title: const Text("Otp confirmation"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 50),
              const Text(
                "Enter the otp code",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 50),
              TextField(
                controller: otpController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'OTP',
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: _timerCountdown > 0
                    ? Text(
                        "Resend in $_timerCountdown s",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      )
                    : TextButton(
                        onPressed: resendOtp,
                        child: Text(
                          "Resend",
                          style: TextStyle(
                            fontSize: 16,
                            color: Constants.blackColor,
                          ),
                        ),
                      ),
              ),
              const SizedBox(height: 50),
              BtnPrincipal(
                text: "Verify",
                onPressed: () {
                  _submitOtp(otpController.text);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
