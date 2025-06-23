import 'package:trackmint/data/model/user_model.dart';

abstract class UserEvent {}

class SignUpEvent extends UserEvent {
  UserModel userModel;
  SignUpEvent({required this.userModel});
}

class LoginEvent extends UserEvent {
  final String email;
  final String password;
  LoginEvent({required this.email, required this.password});
}
