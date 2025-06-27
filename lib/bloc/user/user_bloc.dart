import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackmint/bloc/user/user_event.dart';
import 'package:trackmint/bloc/user/user_state.dart';
import 'package:trackmint/data/model/user_model.dart';
import 'package:trackmint/data/repository/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserRepository userRepository;
  UserBloc({required this.userRepository}) : super(UserInitialState()) {
    on<SignUpEvent>(
      (event, emit) async {
        emit(UserLoadingState());
        await Future.delayed(Duration(seconds: 1));
        String message =
            await userRepository.signUpUser(userModel: event.userModel);
        if (message == "Successfully registerd!") {
          emit(UserSuccessState());
        } else {
          emit(UserFailedState(errorMessage: message));
          print(message);
        }
      },
    );

    on<LoginEvent>(
      (event, emit) async {
        emit(UserLoadingState());

        await Future.delayed(Duration(seconds: 1));
        String message = await userRepository.loginUser(
            userEmail: event.email, userPassword: event.password);
        if (message == "Successfully loged in !") {
          emit(UserSuccessState());
        } else {
          emit(UserFailedState(errorMessage: message));
          print(message);
        }
      },
    );
  }
}
