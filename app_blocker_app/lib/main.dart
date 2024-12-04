import 'package:app_blocker_app/presentation/screens/focuspage.dart';
import 'package:app_blocker_app/presentation/screens/intropage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

// Main MyApp class
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? isFirstTime;

  @override
  void initState() {
    super.initState();
    _checkFirstTime();
  }

  // Check if it's the first time the user is opening the app
  _checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? firstTime = prefs.getBool('isFirstTime');

    // If it's null (first launch), assume it is first time and set to true
    if (firstTime == true) {
      setState(() {
        isFirstTime = true;
      });
    } else {
      setState(() {
        isFirstTime = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'App Blocker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/', // Set initial route
      routes: {
        '/': (context) => isFirstTime == true ? IntroPage() : FocusPage(),
        '/focus': (context) => FocusPage(),
        '/intro': (context) => IntroPage(),
      },
    );
  }
}
