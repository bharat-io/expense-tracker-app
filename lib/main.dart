import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackmint/bloc/user/user_bloc.dart';
import 'package:trackmint/data/local/db_helper.dart';
import 'package:trackmint/data/repository/user_repository.dart';
import 'package:trackmint/utill/app_routes.dart';

void main() {
  DbHelper dbHelper = DbHelper.getInstance();
  runApp(MyApp(dbHelper: dbHelper));
}

class MyApp extends StatelessWidget {
  final DbHelper dbHelper;

  const MyApp({super.key, required this.dbHelper});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => UserBloc(
            userRepository: UserRepository(dbHelper: dbHelper),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: "Poppins",
          useMaterial3: true,
        ),
        initialRoute: AppRoutes.SPLASHSCREEN,
        routes: AppRoutes.routes,
      ),
    );
  }
}
