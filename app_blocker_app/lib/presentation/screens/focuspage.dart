import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async'; // For Timer

class FocusPage extends StatefulWidget {
  @override
  _FocusPageState createState() => _FocusPageState();
}

class _FocusPageState extends State<FocusPage> {
  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;
  int _totalSeconds = 0;
  bool _hardcoreMode = false;
  bool _greyscale = false;
  Timer? _countdownTimer; // To manage the countdown
  bool _isFocusing = false; // Track if timer is running
  int _initialHours = 0,
      _initialMinutes =
          0; // Removed seconds since we're only showing hours and minutes

  void _onTimeSelected(int hours, int minutes) {
    setState(() {
      _initialHours = hours;
      _initialMinutes = minutes;
      _totalSeconds = (_initialHours * 3600) + (_initialMinutes * 60);
      _hours = _initialHours;
      _minutes = _initialMinutes;
      _seconds = 0; // Reset seconds when the time is selected
    });
  }

  // Start or stop the timer
  void _toggleTimer() {
    if (_isFocusing) {
      // Stop the timer and reset
      _countdownTimer?.cancel();
      setState(() {
        _isFocusing = false;
        // Reset all values when stopping the timer
        _hours = 0;
        _minutes = 0;
        _seconds = 0;
        _totalSeconds = 0;
      });
    } else {
      // Start the timer with user input
      _totalSeconds = (_initialHours * 3600) + (_initialMinutes * 60);
      _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (_totalSeconds > 0) {
          setState(() {
            _totalSeconds--;
            _hours = _totalSeconds ~/ 3600;
            _minutes = (_totalSeconds % 3600) ~/ 60;
            _seconds = _totalSeconds % 60;
          });
        } else {
          _countdownTimer?.cancel();
          setState(() {
            _isFocusing = false;
          });
        }
      });
      setState(() {
        _isFocusing = true;
      });
    }
  }

  @override
  void dispose() {
    // Clean up the timer when the widget is disposed
    _countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageDisplay(context),
    );
  }

  Stack pageDisplay(BuildContext context) {
    return Stack(
      children: [
        // The two containers positioned at the bottom
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30), // Padding from bottom
            child: Column(
              mainAxisSize: MainAxisSize.min, // Minimize the column size
              children: [
                // First container with border, white background, and shadow
                Container(
                  height: 80,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Colors.white, // Set the background color to white
                    borderRadius: BorderRadius.circular(15), // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.6), // Light shadow
                        blurRadius: 10, // Shadow blur radius
                        offset: Offset(0, 4), // Shadow position
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Goals",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container()
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Second container with same style (white, border, shadow)
                Container(
                  height: 80,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Colors.white, // Set the background color to white
                    borderRadius: BorderRadius.circular(15), // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.6), // Light shadow
                        blurRadius: 10, // Shadow blur radius
                        offset: Offset(0, 4), // Shadow position
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Blocked Apps",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Custom Time Picker Layout
        Align(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 50),

              // Time Display (HH:MM or HH:MM:SS) to show the selected time
              GestureDetector(
                onTap: () {
                  _showTimePicker(
                    context: context,
                    initialHours: _initialHours,
                    initialMinutes: _initialMinutes,
                    onTimeSelected: _onTimeSelected, // Pass the callback
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Text(
                    _isFocusing
                        ? "${_hours.toString().padLeft(2, '0')}:${_minutes.toString().padLeft(2, '0')}:${_seconds.toString().padLeft(2, '0')}"
                        : "${_hours.toString().padLeft(2, '0')}:${_minutes.toString().padLeft(2, '0')}",
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),
              // Start/Stop Timer Button
              MaterialButton(
                onPressed: _toggleTimer,
                color: _isFocusing ? Colors.green : Colors.red[400],
                shape: CircleBorder(),
                padding: EdgeInsets.all(15),
                minWidth: 150,
                height: 150,
                child: Text(
                  _isFocusing ? "Focusing" : "Focus",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    // Hardcore Mode toggle
                    // Hardcore Mode toggle
                    CupertinoFormRow(
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween, // Distribute space
                        children: [
                          Text(
                            "Hardcore Mode",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          CupertinoSwitch(
                            value: _hardcoreMode,
                            onChanged: (bool value) {
                              setState(() {
                                _hardcoreMode = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 1),
                    CupertinoFormRow(
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween, // Distribute space
                        children: [
                          Text(
                            "Greyscale",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          CupertinoSwitch(
                            value: _greyscale,
                            onChanged: (bool value) {
                              setState(() {
                                _greyscale = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Define a method that accepts a callback to update the parent widget's state.
void _showTimePicker({
  required BuildContext context,
  required int initialHours,
  required int initialMinutes,
  required Function(int, int)
      onTimeSelected, // Callback function to pass back selected time
}) {
  int hours = initialHours;
  int minutes = initialMinutes;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 16,
        child: StatefulBuilder(
          // Use StatefulBuilder here to update the dialog itself
          builder: (context, setDialogState) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Custom Time Display
                  Text(
                    "Select Time",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),

                  // Time Picker UI for hours and minutes
                  Column(
                    children: [
                      // Hours selection
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              setDialogState(() {
                                hours =
                                    (hours - 1) % 24; // Adjust hours backward
                                if (hours < 0) {
                                  hours = 23; // Handle negative values
                                }
                              });
                            },
                            icon: Icon(Icons.arrow_left),
                            iconSize: 40,
                          ),
                          Text(
                            hours.toString().padLeft(2, '0'),
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setDialogState(() {
                                hours =
                                    (hours + 1) % 24; // Adjust hours forward
                              });
                            },
                            icon: Icon(Icons.arrow_right),
                            iconSize: 40,
                          ),
                        ],
                      ),
                      // Minutes selection
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              setDialogState(() {
                                minutes = (minutes - 1) %
                                    60; // Adjust minutes backward
                                if (minutes < 0) {
                                  minutes = 59; // Handle negative values
                                }
                              });
                            },
                            icon: Icon(Icons.arrow_left),
                            iconSize: 40,
                          ),
                          Text(
                            minutes.toString().padLeft(2, '0'),
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setDialogState(() {
                                minutes = (minutes + 1) %
                                    60; // Adjust minutes forward
                              });
                            },
                            icon: Icon(Icons.arrow_right),
                            iconSize: 40,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 30),

                  // Confirm Button
                  ElevatedButton(
                    onPressed: () {
                      // Pass the selected time back to the parent widget
                      onTimeSelected(hours, minutes);
                      Navigator.of(context).pop(); // Close the overlay
                    },
                    child: Text("OK"),
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}
