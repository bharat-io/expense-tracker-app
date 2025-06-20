import 'package:flutter/material.dart';
import 'package:trackmint/ui/screens/login_screen.dart';
import 'package:trackmint/utill/app_routes.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_buildTextFields(context)],
        ),
      ),
    );
  }

  Widget _buildTextFields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Create Account",
          style: TextStyle(
              fontSize: 24,
              color: Color(0xFF333333),
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        TextField(
          decoration: InputDecoration(
            hintText: "Full Name",
            prefixIcon: Icon(Icons.person),
            filled: true,
            fillColor: Color(0xFFDDF6D2),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: "Phone Number",
            prefixIcon: Icon(Icons.email),
            filled: true,
            fillColor: Color(0xFFDDF6D2),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            hintText: "Email",
            prefixIcon: Icon(Icons.lock),
            filled: true,
            fillColor: Color(0xFFDDF6D2),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 24),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            hintText: "Password",
            prefixIcon: Icon(Icons.lock),
            filled: true,
            fillColor: Color(0xFFDDF6D2),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // signUp logic

              Navigator.pushReplacementNamed(context, AppRoutes.LOGINSCREEN);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFB0DB9C),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              "Sign Up",
              style: TextStyle(fontSize: 16, color: Color(0xFF333333)),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Already have an account? "),
            InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, AppRoutes.LOGINSCREEN);
              },
              child: Text(
                "Login",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6BCB77),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
