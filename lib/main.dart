import 'package:flutter/material.dart';
import 'package:trackmint/view/screens/home_screen.dart';
import 'package:trackmint/view/screens/login_screen.dart';
import 'package:trackmint/view/screens/signUp_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: LoginScreen());
  }
}
