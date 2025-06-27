import 'package:trackmint/data/model/user_model.dart';

abstract class UserState {}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserSuccessState extends UserState {
  List<UserModel>? userModel;
  UserSuccessState({this.userModel});
}

class UserFailedState extends UserState {
  String errorMessage;
  UserFailedState({required this.errorMessage});
}
