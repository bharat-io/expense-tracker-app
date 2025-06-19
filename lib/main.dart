import 'package:flutter/material.dart';

import 'package:trackmint/utill/app_routes.dart';

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
        fontFamily: "Poppins",
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.SPLASHSCREEN,
      routes: AppRoutes.routes,
    );
  }
}
