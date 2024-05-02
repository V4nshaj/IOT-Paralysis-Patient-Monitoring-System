import 'package:flutter/foundation.dart';
import 'package:paramov/components/notification_service.dart';
import 'package:paramov/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:paramov/home.dart';
import 'package:paramov/screens/startup_screen.dart';
import 'package:paramov/screens/welcome_screen.dart';
import 'package:paramov/screens/registration_screen.dart';
import 'package:paramov/screens/login_screen.dart';
import 'package:paramov/screens/vital_screen.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //some platform integration features may not be available until the binding has been initialized.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (!kIsWeb) {
    //for website
    await NotificationController.initializeLocalNotifications();
    await NotificationController.initializeRemoteNotifications(debug: true);
    await NotificationController.getInitialNotificationAction();
  }
  runApp(Paramov());
}

class Paramov extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>(); //keys passed are global
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey:
          navigatorKey, //if in no screen then it helps in navigation getting context if out stateful widget
      debugShowCheckedModeBanner: false,
      //welcomeScreen.id associate with Welcomescreen as string name can be misspelled but id never changes
      initialRoute: WelcomeScreen
          .id, //initial route is defined as / bcz home is not consider if inital route is defined
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        StartupScreen.id: (context) => StartupScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        VitalScreen.id: (context) => VitalScreen(
              user: '',
            ),
      },
      // home: WelcomeScreen(), //for home page
    );
  }
}
