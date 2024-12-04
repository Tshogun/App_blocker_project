import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset(
              'assets/start_page/Achieve.json',
              repeat: true,
              reverse: false,
              animate: true,
            ),
          ),
          SizedBox(height: 40,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ElevatedButton(
                onPressed: () {
                  _setUserAsNotFirstTime(context);
                  Navigator.pushReplacementNamed(
                      context, '/focus'); //imported from main.dart
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 40.0),
                  child: Text(
                    "Get Started",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                  padding: EdgeInsets.zero,
                  backgroundColor: const Color.fromARGB(255, 164, 188, 231),
                )),
          ),
        ],
      ),
    );
  }

  // private function to label that the user has now visited the //
  //intropage and need not to show it ever again//
  void _setUserAsNotFirstTime(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isFirstTime', false);
  }
}
