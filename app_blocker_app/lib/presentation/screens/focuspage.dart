import 'package:flutter/material.dart';

class FocusPage extends StatefulWidget {
  const FocusPage({super.key});
  @override
  State<FocusPage> createState() => _FocusPageState();
}

class _FocusPageState extends State<FocusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [ElevatedButton(onPressed:() {}, child: const Text("Hello"))],)
    );
  }
}