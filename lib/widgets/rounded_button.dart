import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String buttontitle;
  final Color buttoncolor;
  final Function()? onpressed;

  RoundedButton(
      {required this.buttoncolor, required this.onpressed, required this.buttontitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: buttoncolor,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onpressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            '$buttontitle',
            style: TextStyle(
                color: Colors.white
            ),
          ),
        ),
      ),
    );
  }
}