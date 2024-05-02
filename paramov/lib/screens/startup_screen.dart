import 'package:flutter/material.dart';
import 'package:paramov/screens/welcome_screen.dart';

class StartupScreen extends StatefulWidget {
  const StartupScreen({super.key});
  static const String id = 'Startup_screen';

  @override
  State<StartupScreen> createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hi App'),
      ),
      body: Center(
        child: Text(
          'Hi!',
          style: TextStyle(fontSize: 32.0),
        ),
      ),
    );
  }
}
