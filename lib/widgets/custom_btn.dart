import 'package:boundless/utils/constants.dart';
import 'package:flutter/material.dart';

class BtnPrincipal extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const BtnPrincipal({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Constants.whiteColor),
            foregroundColor: MaterialStateProperty.all(Constants.blackColor),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)))),
        child: Text(
          text,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
