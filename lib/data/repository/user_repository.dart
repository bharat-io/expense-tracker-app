import 'package:trackmint/data/local/db_helper.dart';
import 'package:trackmint/data/model/user_model.dart';

class UserRepository {
  DbHelper dbHelper;
  UserRepository({required this.dbHelper});
  Future<String> signUpUser({required UserModel userModel}) async {
    bool emailExist =
        await dbHelper.isAlreadyEmailExist(email: userModel.email);
    if (emailExist) {
      return "Email already exists";
    } else {
      bool check = await dbHelper.registerUser(userModel: userModel);
      return check ? "Successfully registerd!" : "Failed to register..";
      //alternate process
      // if (check) {
      //   return "Register sucessfully";
      // } else {
      //   "Register failed";
      // }
    }
  }

  Future<String> loginUser(
      {required String userEmail, required String userPassword}) async {
    if (await dbHelper.isAlreadyEmailExist(email: userEmail)) {
      if (await dbHelper.checkEmailAndPasswordExist(
          email: userEmail, password: userPassword)) {
        return "Successfully loged in !";
      } else {
        return "Incorrect password";
      }
    } else {
      return "user does not exist with this email!";
    }
  }
}
