import 'package:trackmint/data/model/user_model.dart';

abstract class UserState {}

class UserInitialState extends UserState {}

class UserSignUpLoadingState extends UserState {}

class UserSignUpSuccessState extends UserState {
  List<UserModel>? userModel;
  UserSignUpSuccessState({this.userModel});
}

class UserSignUpFailedState extends UserState {
  String errorMessage;
  UserSignUpFailedState({required this.errorMessage});
}

class UserLoginLoadingState extends UserState {}

class UserLoginSuccessState extends UserState {
  List<UserModel>? userModel;
  UserLoginSuccessState({this.userModel});
}

class UserLoginFailedState extends UserState {
  String errorMessage;
  UserLoginFailedState({required this.errorMessage});
}
