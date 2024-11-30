import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // Import Lottie package
import 'package:addiction_breaker_app_blocker/data/models/nav_item_model.dart';

Color bottomNbColor = Color(0xFF1D3557).withOpacity(0.6); // Dark Blue for navbar
const Color fabColor = Color.fromARGB(255, 19, 114, 223); // Bright Green for FAB

class BottomNavAnimated extends StatefulWidget {
  const BottomNavAnimated({super.key});

  @override
  State<BottomNavAnimated> createState() => _BottomNavAnimatedState();
}

class _BottomNavAnimatedState extends State<BottomNavAnimated> {
  int _selectedIndex = 1; // Track the selected index

  // Handle tap on each navigation item
  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update selected index
    });

    // Optionally, navigate to the route (if any)
    // Navigator.pushNamed(context, NavItems[index].route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _onNavItemTapped(1);
        },
        shape: CircleBorder(),

        backgroundColor: fabColor,
        child: Lottie.asset(navItems[1].gifAssetPath),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 80,
          width: double.infinity,
          decoration: BoxDecoration(
            color: bottomNbColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Row(children: [],),
        ),
      ),
    );
  }
}
