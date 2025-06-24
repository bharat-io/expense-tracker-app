import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackmint/bloc/user/user_bloc.dart';
import 'package:trackmint/bloc/user/user_event.dart';
import 'package:trackmint/bloc/user/user_state.dart';
import 'package:trackmint/data/model/user_model.dart';
import 'package:trackmint/ui/widgets/app_snackbar.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocConsumer<UserBloc, UserState>(
                        builder: (context, state) {
                          return Column(
                            children: [
                              _buildTextFields(context),
                            ],
                          );
                        },
                        listener: (context, state) {
                          if (state is UserLoadingState) {
                            isLoading = true;
                          } else if (state is UserSuccessState) {
                            if (context.mounted) {
                              Navigator.of(context).pop();
                              isLoading = true;
                            }
                          } else if (state is UserFailedState) {
                            AppSnackbar.showSnackBar(
                              context,
                              contentText: state.errorMessage,
                            );
                            isLoading = false;
                          }
                        },
                      ),
                    ],
                  ),
                ),
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
              if (nameController.text.isEmpty &&
                  phoneController.text.isEmpty &&
                  emailController.text.isEmpty &&
                  passwordController.text.isEmpty) {
                AppSnackbar.showSnackBar(context,
                    contentText: "enter all valid details!");
                return;
              } else if (nameController.text.isEmpty) {
                AppSnackbar.showSnackBar(context,
                    contentText: "enter valid name!");
                return;
              } else if (phoneController.text.isEmpty) {
                AppSnackbar.showSnackBar(context,
                    contentText: "enter valid phoneNumber!");
                return;
              } else if (emailController.text.isEmpty) {
                AppSnackbar.showSnackBar(context,
                    contentText: "enter valid email!");
                return;
              } else if (passwordController.text.isEmpty) {
                AppSnackbar.showSnackBar(context,
                    contentText: "enter valid password!");
                return;
              }

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
            child: isLoading
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Sign Up",
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
                          )),
                    ],
                  )
                : const Text(
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
                Navigator.of(context).pop();
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
