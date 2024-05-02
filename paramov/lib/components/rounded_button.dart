import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text; //change nhi hoga
  VoidCallback onPressed; //call back
  Color colored;
  RoundedButton(
      {required this.text, required this.colored, required this.onPressed}) {}
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colored,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            text, //'Log In'
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
