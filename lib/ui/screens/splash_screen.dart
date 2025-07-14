import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackmint/utill/app_constant.dart';
import 'package:trackmint/utill/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      checkIsAuthenticated();
    });
  }

  void checkIsAuthenticated() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int? userToken = sharedPreferences.getInt(AppConstant.TOKEN_KEY) ?? 0;
    String navigateTo = AppRoutes.LOGINSCREEN;
    if (userToken > 0) {
      navigateTo = AppRoutes.HOME_SCREEN;
    }
    Navigator.pushReplacementNamed(context, navigateTo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF2F2F2),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/splash_logo2.png",
              width: 500,
            ),
            Text(
              "TrackMint",
              style: TextStyle(
                fontSize: 40,
                color: Color(0xFF333333),
              ),
            )
          ],
        ));
  }
}
