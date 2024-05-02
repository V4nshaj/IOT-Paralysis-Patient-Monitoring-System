import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddButton extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  VoidCallback onTap;
  AddButton(
      {required this.text,
      required this.width,
      required this.height,
      required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      //creates clickable areas i.e increases to touch area
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          // color: Colors.white,
          color: const Color.fromARGB(255, 155, 106, 239),
          borderRadius: BorderRadius.circular(10.0),
        ),
        width:
            MediaQuery.of(context).size.width * width, //screen size 80 % width
        height: MediaQuery.of(context).size.width * height,
        padding: EdgeInsets.symmetric(vertical: 5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 15.0),
            ),
          ],
        ),
      ),
    );
  }
}
