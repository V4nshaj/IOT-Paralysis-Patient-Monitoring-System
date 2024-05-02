import 'package:flutter/material.dart';

class Purple_overlay extends StatelessWidget {
  const Purple_overlay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.topLeft, // Adjust alignment for tilt
      transform: Matrix4.skewY(
          -0.4), // Adjust angle for tilt (negative for slight left tilt)
      child: Container(
        margin: EdgeInsets.only(top: 120.0),
        color: Colors.purple.withOpacity(0.1), // Set purple color with opacity
        height: MediaQuery.of(context).size.height *
            0.35, // Set medium height (50%)
        width: double.infinity, // Set medium width (50%)
      ),
    );
  }
}
