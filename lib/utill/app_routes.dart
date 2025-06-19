import 'package:flutter/material.dart';
import 'package:trackmint/ui/screens/splash_screen.dart';

class AppRoutes {
  static const String SPLASHSCREEN = "/splash";
  static const String SIGNUPSCREEN = "/signUpScreen";
  static const String LOGINSCREEN = "/loginScreen";
  static const String EXPENSESCREEN = "/expenseScreen";

  static Map<String, Widget Function(BuildContext)> routes = {
    SPLASHSCREEN: (context) => SplashScreen()
  };
}
