import 'package:flutter/material.dart';
import 'package:paramov/components/rounded_button.dart';
import 'package:paramov/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:paramov/screens/vital_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:paramov/widget/add_button.dart';
import 'package:paramov/widget/purple_overlay.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum LoginState { Login, Register }

class RegistrationScreen extends StatefulWidget {
  static const String id = 'Registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool showspinner = false;
  late String name;
  late String email;
  late String password;
  final _formKey = GlobalKey<FormState>(); // Key for form validation
  LoginState _currentState = LoginState.Login;
  void toggleState() {
    setState(() {
      _currentState = _currentState == LoginState.Login
          ? LoginState.Register
          : LoginState.Login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentState == LoginState.Login ? 'Login' : 'Register'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showspinner,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    // Background image
                    // Tilted purple overlay
                    Purple_overlay(),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Image.asset(
                          'images/logo.png', // Replace with your image path
                          width: MediaQuery.of(context).size.width *
                              0.3, // 80% of screen width
                          height: MediaQuery.of(context).size.height * 0.3,
                        ),
                      ),
                    ),
                  ],
                ),
                // Email field
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    //Do something with the user input.
                    email = value;
                  },
                  decoration: kInput.copyWith(hintText: 'Enter your email'),
                ),
                SizedBox(height: 10.0),
                // Password field
                TextField(
                  obscureText: true, //this change txt into dot or star form
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    //Do something with the user input.
                    password = value;
                  },
                  decoration: kInput.copyWith(hintText: 'Enter your password.'),
                ),
                // Additional fields for registration (conditionally displayed)
                if (_currentState == LoginState.Register)
                  SizedBox(height: 10.0),
                if (_currentState == LoginState.Register)
                  TextField(
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      //Do something with the user input.
                      name = value;
                    },
                    decoration: kInput.copyWith(hintText: 'Enter your Name.'),
                  ),
                SizedBox(height: 20.0),
                // Login/Register button based on current state
                AddButton(
                  text:
                      _currentState != LoginState.Login ? 'Register' : 'Login',
                  width: 0.3,
                  height: 0.1,
                  onTap: () async {
                    if (_currentState != LoginState.Login) {
                      // print(email);
                      // print(password);
                      setState(() {
                        //to show loading animation
                        showspinner = true;
                      });
                      try {
                        final newuser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);
                        if (newuser.user != null) {
                          await FirebaseFirestore.instance
                              .collection('Users')
                              .doc(newuser.user!.displayName)
                              .set({'email': email, 'name': name});
                          Navigator.pushNamedAndRemoveUntil(context,
                              VitalScreen.id, (Route<dynamic> route) => false);
                        }
                        setState(() {
                          //to show loading animation
                          showspinner = false;
                        });
                      } catch (e) {
                        print(e);
                      }
                    }
                    if (_currentState == LoginState.Login) {
                      setState(() {
                        //to show loading animation
                        showspinner = true;
                      });
                      try {
                        final user = await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        if (user != null) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VitalScreen(
                                        user: email,
                                      )),
                              (Route<dynamic> route) => false);
                        }
                        setState(() {
                          //to show loading animation
                          showspinner = false;
                        });
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                ),
                // Toggle button to switch between Login and Register
                TextButton(
                  onPressed: toggleState,
                  child: Text(_currentState != LoginState.Login
                      ? 'Existing User? Login Here'
                      : 'New User? Register Here'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
