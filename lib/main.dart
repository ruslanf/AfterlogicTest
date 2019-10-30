import 'package:afterlogic_test/ui/contact_manager.dart';
import 'package:flutter/material.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Afterlogic Contact Manager',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: ContactManager(title: 'Contact Manager Page'),
    );
  }
}