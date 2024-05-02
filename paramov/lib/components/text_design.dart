import 'package:flutter/material.dart';

final String text = '';
Text bold_text({required boldtext}) {
  return Text(
    boldtext,
    style: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.w400,
    ),
    textAlign: TextAlign.left,
  );
}

final String lighttext = '';
Text light_text({required lighttext}) {
  return Text(
    lighttext,
    style: TextStyle(
      color: Colors.black,
      fontSize: 14.0,
      fontWeight: FontWeight.w300,
    ),
    textAlign: TextAlign.center,
  );
}
