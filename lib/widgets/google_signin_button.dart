import 'package:flutter/material.dart';

class GoogleSignInButton extends StatelessWidget {
  final String buttonText;
  final Function onPressed;
  final IconData icon;
  GoogleSignInButton(
      {required this.buttonText, required this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 2.0,
        horizontal: 5.0,
      ),
      child: ElevatedButton.icon(
        onPressed: () {
          onPressed();
        },
        icon: Icon(
          icon,
          size: 30.0,
          color: Colors.amberAccent,
        ),
        label: Text(
          buttonText,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          minimumSize: Size(150, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),

        // padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        // color: Colors.red,
        // textColor: Colors.white,
      ),
    );
  }
}
