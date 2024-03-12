import 'package:boundless/screens/otp_confirmation_screen.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:boundless/utils/constants.dart';
import 'package:boundless/widgets/custom_btn.dart';
import 'signup_screen.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({Key? key}) : super(key: key);
  static const String id = 'phone_auth';

  @override
  _PhoneAuthState createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String countryCode = '+90';

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    return null;
  }

  void _onCountryChange(CountryCode cCode) {
    setState(() {
      countryCode = cCode.toString();
    });
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.mainColor,
      appBar: AppBar(
        title: Text("Sign up"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Enter your phone number",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Form(
              key: _formKey,
              child: Container(
                color: Constants.whiteColor,
                child: Row(
                  children: [
                    CountryCodePicker(
                      onChanged: _onCountryChange,
                      initialSelection: 'TR',
                      favorite: const ['+90', 'TR'],
                      showCountryOnly: false,
                      showOnlyCountryWhenClosed: false,
                      alignLeft: false,
                      textStyle: const TextStyle(
                        fontSize: 18,
                        color: Constants.blackColor,
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _phoneNumberController,
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(fontSize: 18),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Phone number',
                          hintStyle: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        validator: _validatePhoneNumber,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50),
            BtnPrincipal(
              text: "Next",
              onPressed: () {
                String phoneNumber = _phoneNumberController.text;

                String completePhoneNumber = countryCode + phoneNumber;

                if (_formKey.currentState!.validate()) {
                  // Form is valid, navigate to the next screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OtpConfirmationScreen(
                          phoneNumber: completePhoneNumber),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
