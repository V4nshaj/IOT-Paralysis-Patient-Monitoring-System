import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paramov/components/text_design.dart';
import 'package:paramov/components/rounded_button.dart';
import 'package:paramov/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:paramov/screens/vital_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:paramov/widget/add_button.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Add Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.2, // 20% top padding
          left: MediaQuery.of(context).size.width * 0.1, // 10% left padding
          right: MediaQuery.of(context).size.width * 0.1, // 10% left padding
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            bold_text(boldtext: 'Complete Profile'),
            light_text(lighttext: 'Few basics information to get you started'),
            SizedBox(height: 20.0),
            Row(
              children: [
                AddButton(
                    text: 'Male', width: 0.25, height: 0.08, onTap: () {}),
                SizedBox(
                    width: MediaQuery.of(context).size.width *
                        0.3), // Spacing between buttons
                AddButton(
                    text: 'Female', width: 0.25, height: 0.08, onTap: () {})
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Date of birth',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Adjust border radius as needed
                  ),
                ),
              ),
            ),
            SizedBox(height: 1.0), // Spacing between text fields
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Height',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Adjust border radius as needed
                  ),
                ),
              ),
            ),
            SizedBox(height: 1.0), // Spacing between rows
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Weight',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Adjust border radius as needed
                  ),
                ),
              ),
            ),
            SizedBox(height: 1.0), // Spacing between text fields
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Blood type',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Adjust border radius as needed
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
