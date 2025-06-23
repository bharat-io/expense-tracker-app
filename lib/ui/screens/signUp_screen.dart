import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackmint/bloc/user/user_bloc.dart';
import 'package:trackmint/bloc/user/user_event.dart';
import 'package:trackmint/bloc/user/user_state.dart';
import 'package:trackmint/data/model/user_model.dart';
import 'package:trackmint/utill/app_routes.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserSuccessState) {
            Navigator.pop(context);
          } else if (state is UserFailedState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
        },
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 230, left: 18, right: 18),
                    child: _buildTextFields(context),
                  ),
                ],
              ),
            );
          },
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
          controller: nameController,
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
          controller: phoneController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "Phone Number",
            prefixIcon: Icon(Icons.phone),
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
          controller: emailController,
          obscureText: false,
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
          controller: passwordController,
          obscureText: false,
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
              context.read<UserBloc>().add(SignUpEvent(
                  userModel: UserModel(
                      name: nameController.text,
                      email: emailController.text,
                      phone: phoneController.text.toString(),
                      password: passwordController.text.toString())));
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
