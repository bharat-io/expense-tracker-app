import 'package:trackmint/data/local/db_helper.dart';

class UserModel {
  int? userId;
  String name;
  String email;
  String phone;
  String password;
  UserModel(
      {this.userId,
      required this.name,
      required this.email,
      required this.phone,
      required this.password});

  // model to map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        name: DbHelper.USER_NAME,
        email: DbHelper.USER_EMAIL,
        phone: DbHelper.USER_PHONE,
        password: DbHelper.USER_PASSWORD);
  }

  // map to model

  Map<String, dynamic> toMap() {
    return {
      DbHelper.USER_NAME: name,
      DbHelper.USER_EMAIL: email,
      DbHelper.USER_PHONE: phone,
      DbHelper.USER_PASSWORD: password
    };
  }
}
