import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackmint/bloc/user/user_bloc.dart';
import 'package:trackmint/bloc/user/user_event.dart';
import 'package:trackmint/bloc/user/user_state.dart';
import 'package:trackmint/ui/widgets/app_snackbar.dart';
import 'package:trackmint/utill/app_routes.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  // void isAuthenticated() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   sharedPreferences.
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF2F2F2),
        body: BlocConsumer<UserBloc, UserState>(builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLoginForm(context),
              ],
            ),
          );
        }, listener: (context, state) {
          if (state is UserLoginLoadingState) {
            isLoading = true;
          } else if (state is UserLoginSuccessState) {
            isLoading = false;
            AppSnackbar.showSnackBar(context, contentText: "Login successful!");
            Navigator.of(context).pushReplacementNamed(AppRoutes.HOME_SCREEN);
          } else if (state is UserLoginFailedState) {
            isLoading = false;
            AppSnackbar.showSnackBar(context, contentText: state.errorMessage);
          }
        }));
  }

  Widget _buildLoginForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Login to your Account !",
          style: TextStyle(
            fontSize: 24,
            color: Color(0xFF333333),
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: "email",
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
          controller: passwordController,
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
            onPressed: () async {
              if (emailController.text.isEmpty &&
                  passwordController.text.isEmpty) {
                AppSnackbar.showSnackBar(context,
                    contentText: "Please enter valid details!");
                return;
              } else if (emailController.text.isEmpty) {
                AppSnackbar.showSnackBar(context,
                    contentText: "Please enter valid email!");
                return;
              } else if (passwordController.text.isEmpty) {
                AppSnackbar.showSnackBar(context,
                    contentText: "Plese enter valid password");
                return;
              }
              context.read<UserBloc>().add(LoginEvent(
                  email: emailController.text,
                  password: passwordController.text));

              // SharedPreferences sharedPreferences =
              //     await SharedPreferences.getInstance();
              //     sharedPreferences.setInt(key, value)
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFB0DB9C),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: isLoading
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Login",
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF333333)),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      SizedBox(
                        height: 15,
                        width: 15,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                        ),
                      )
                    ],
                  )
                : const Text(
                    "Login",
                    style: TextStyle(fontSize: 16, color: Color(0xFF333333)),
                  ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Don't have an account? "),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.SIGNUPSCREEN);
              },
              child: Text(
                "Sign Up",
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
