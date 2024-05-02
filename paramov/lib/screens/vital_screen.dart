import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:paramov/components/notification_service.dart';
import 'package:paramov/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:paramov/components/Nmethod.dart';
import 'package:paramov/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:paramov/widget/purple_overlay.dart';
import 'package:google_fonts/google_fonts.dart';

final _firestore = FirebaseFirestore.instance;
User? logedinuser;
var MyName;

class VitalScreen extends StatefulWidget {
  final String user;
  VitalScreen({required this.user});

  static const String id = 'Vital_screen';

  @override
  _VitalScreenState createState() => _VitalScreenState();
}

class _VitalScreenState extends State<VitalScreen> {
  final _auth = FirebaseAuth.instance;
  String? need1;
  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      NotificationController.initializeContext(context);
      NotificationController.startListeningNotificationEvents();
      NotificationController.requestFirebaseToken();
    }
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;

      if (user != null) {
        logedinuser = user;
        print(logedinuser);
        MyName = user.displayName!;
        print(MyName);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality

                // msgStream();
                _auth.signOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, WelcomeScreen.id, (Route<dynamic> route) => false);
              }),
        ],
        title: Row(
          children: [
            Image.asset(
              'images/logo.png',
              width: 30.0,
              height: 30.0,
            ),
            Text('Paramov'),
          ],
        ),
        backgroundColor: Colors.purple.withOpacity(0.1),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  @override
  Widget build(BuildContext context) {
    return //stream helps display snapshot of messages in column
        StreamBuilder(
            //declaring StreamBuilder as QuerySnapshot
            //alaways declare any function beforehand
            stream: ref.onValue,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                      backgroundColor: Colors.lightBlueAccent),
                );
              } else {
                Map<dynamic, dynamic> messages = snapshot.data!.snapshot.value
                    as dynamic; //to access the data in async
                //async from steambuilder contains QuerySnapshot, QuerySnapshot contains document list

                var need1;
                var need2;
                var need3;
                var need4;
                var temperatureText;
                //typecasting object to String
                need1 = messages['need1'];
                need2 = messages['need2'];
                need3 = messages['need3'];
                need4 = messages['need4'];
                temperatureText = messages['temperature'];
                nmethod(need1, need2, need3, need4);
                // int level1 = need1;
                // int level = 1500;
                // int consumption = level - level1;
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Hey Vanshaj,', //${MyName}
                        style: GoogleFonts.quintessential(
                          textStyle: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.w600),
                        ),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: 20.0),
                      // Large container with rounded corners
                      Container(
                        height: 300.0,
                        width: 340.0, // Occupy full width
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: Colors.purple.withOpacity(0.1),
                        ),
                        child: Column(
                          children: [
                            Image.asset(
                              'images/image1.png', // Replace with your image path
                              width: 150.0, // 80% of screen width
                              height: 150.0,
                            ),
                            SizedBox(height: 20.0),
                            Text(
                              'Temperature: ${temperatureText} °F',
                              style: GoogleFonts.quintessential(
                                textStyle: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30.0), // Add spacing

                      // Row with two containers
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 150.0,
                            width: 150.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              color: need1 < 11
                                  ? Colors.purple.withOpacity(0.1)
                                  : Colors.purple.withOpacity(0.5),
                            ),
                            child: Center(
                                child: Text(
                              'Assisstance',
                              style: GoogleFonts.quintessential(
                                textStyle: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            )),
                          ),
                          Container(
                            height: 150.0,
                            width: 150.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              color: need2 < 12
                                  ? Colors.purple.withOpacity(0.1)
                                  : Colors.purple.withOpacity(0.5),
                            ),
                            child: Center(
                                child: Text(
                              'Water',
                              style: GoogleFonts.quintessential(
                                textStyle: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            )),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30.0), // Add spacing

                      // Row with two remaining containers
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 150.0,
                            width: 150.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              color: need3 < 23
                                  ? Colors.purple.withOpacity(0.1)
                                  : Colors.purple.withOpacity(0.5),
                            ),
                            child: Center(
                                child: Text(
                              'Food',
                              style: GoogleFonts.quintessential(
                                textStyle: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            )),
                          ),
                          Container(
                            height: 150.0,
                            width: 150.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              color: need4 < 23
                                  ? Colors.purple.withOpacity(0.1)
                                  : Colors.purple.withOpacity(0.5),
                            ),
                            child: Center(
                                child: Text(
                              'Restroom',
                              style: GoogleFonts.quintessential(
                                textStyle: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            )),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
            });
  }
}
