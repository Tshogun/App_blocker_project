import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_blocker_app/presentation/components/navbar.dart';  // Ensure correct import for CustomNavbarPage

void main() {
  runApp(MaterialApp(home: MyApp(), debugShowCheckedModeBanner: false,));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Blocker',
      debugShowCheckedModeBanner: false,
      home: CustomNavbarPage(), // Your custom navigation page
    );
  }
}
