import 'package:flutter/material.dart';
import 'package:trackmint/ui/screens/expense_screen.dart';
import 'package:trackmint/ui/screens/home_screen.dart';
import 'package:trackmint/ui/screens/login_screen.dart';
import 'package:trackmint/ui/screens/signup_screen.dart';
import 'package:trackmint/ui/screens/splash_screen.dart';

class AppRoutes {
  static const String SPLASHSCREEN = "/splashScreen";
  static const String HOME_SCREEN = "/homeScreen";
  static const String SIGNUPSCREEN = "/signUpScreen";
  static const String LOGINSCREEN = "/loginScreen";
  static const String EXPENSESCREEN = "/expenseScreen";

  static Map<String, Widget Function(BuildContext)> routes = {
    SPLASHSCREEN: (context) => SplashScreen(),
    HOME_SCREEN: (context) => HomeScreen(),
    SIGNUPSCREEN: (context) => SignUpScreen(),
    LOGINSCREEN: (context) => LoginScreen(),
    EXPENSESCREEN: (context) => ExpenseScreen(),
  };
}
