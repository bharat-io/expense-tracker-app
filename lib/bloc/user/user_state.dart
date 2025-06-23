abstract class UserState {}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserSuccessState extends UserState {}

class UserFailedState extends UserState {
  String errorMessage;
  UserFailedState({required this.errorMessage});
}
