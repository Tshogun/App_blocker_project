import 'package:app_blocker_app/presentation/screens/focuspage.dart';
import 'package:app_blocker_app/presentation/screens/progresspage.dart';
import 'package:flutter/material.dart';

class CustomNavbarPage extends StatefulWidget {
  @override
  _CustomNavbarPageState createState() => _CustomNavbarPageState();
}

class _CustomNavbarPageState extends State<CustomNavbarPage> {
  int _selectedIndex = 0;

  // List of pages to show based on selected index
  final List<Widget> _pages = [
    FocusPage(),    // FocusPage when the first tab is selected
    ProgressPage(), // ProgressPage when the second tab is selected
  ];

  // Handle tab selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Show page based on selected index

      // Custom bottom navigation bar
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.blueAccent, // Navbar background color
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          children: [
            // First icon (FocusPage)
            Expanded(
              child: GestureDetector(
                onTap: () => _onItemTapped(0),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: _selectedIndex == 0 ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home,
                        color: _selectedIndex == 0 ? Colors.blue : Colors.white,
                        size: 30,
                      ),
                      if (_selectedIndex == 0)
                        AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          height: 4,
                          width: 24,
                          color: Colors.blue, // Blue underline for selected tab
                        ),
                    ],
                  ),
                ),
              ),
            ),

            // Second icon (ProgressPage)
            Expanded(
              child: GestureDetector(
                onTap: () => _onItemTapped(1),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: _selectedIndex == 1 ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search,
                        color: _selectedIndex == 1 ? Colors.blue : Colors.white,
                        size: 30,
                      ),
                      if (_selectedIndex == 1)
                        AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          height: 4,
                          width: 24,
                          color: Colors.blue, // Blue underline for selected tab
                        ),
                    ],
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
