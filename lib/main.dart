import 'package:afterlogic_test/ui/contact_manager.dart';
import 'package:flutter/material.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Afterlogic Contact Manager',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: ContactManager(),
    );
  }
}