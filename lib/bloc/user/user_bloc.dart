import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackmint/bloc/user/user_event.dart';
import 'package:trackmint/bloc/user/user_state.dart';
import 'package:trackmint/data/model/user_model.dart';
import 'package:trackmint/repository/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserRepository userRepository;
  UserBloc({required this.userRepository}) : super(UserInitialState()) {
    on<SignUpEvent>(
      (event, emit) async {
        emit(UserSignUpLoadingState());
        await Future.delayed(Duration(seconds: 1));
        String message =
            await userRepository.signUpUser(userModel: event.userModel);
        if (message == "Successfully registerd!") {
          emit(UserSignUpSuccessState());
        } else {
          emit(UserSignUpFailedState(errorMessage: message));
          print(message);
        }
      },
    );

    on<LoginEvent>(
      (event, emit) async {
        emit(UserLoginLoadingState());

        await Future.delayed(Duration(seconds: 1));
        String message = await userRepository.loginUser(
            userEmail: event.email, userPassword: event.password);
        if (message == "Successfully loged in !") {
          emit(UserLoginSuccessState());
        } else {
          emit(UserLoginFailedState(errorMessage: message));
          print(message);
        }
      },
    );
  }
}
