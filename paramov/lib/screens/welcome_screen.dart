import 'package:flutter/foundation.dart';
import 'package:paramov/components/notification_service.dart';
import 'package:paramov/screens/login_screen.dart';
import 'package:paramov/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:paramov/screens/vital_screen.dart';
import 'package:paramov/widget/purple_overlay.dart';
import 'package:paramov/widget/add_button.dart';
import 'package:paramov/components/text_design.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!kIsWeb) {
      NotificationController.initializeContext(context);
      NotificationController.startListeningNotificationEvents();
      NotificationController.requestFirebaseToken();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Get Instant Monitoring for Patients',
              style: TextStyle(
                color: Colors.black,
                fontSize: 26.0,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            Text(
              'Paramov streams real-time patient health insights for abnormality detection and interventions.',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 25.0),
            Stack(
              children: [
                // Background image
                // Tilted purple overlay
                Purple_overlay(),
                Center(
                  child: Image.asset(
                    'images/doc1.png', // Replace with your image path
                    width: MediaQuery.of(context).size.width *
                        0.8, // 80% of screen width
                    height: MediaQuery.of(context).size.height * 0.5,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0), // Add spacing between image and button
            AddButton(
              text: 'Get Started',
              width: 0.8,
              height: 0.15,
              onTap: () async {
                await NotificationController.createNewNotification(
                    "Application Started", "Testing Notification");
                Navigator.pushNamedAndRemoveUntil(context,
                    RegistrationScreen.id, (Route<dynamic> route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
