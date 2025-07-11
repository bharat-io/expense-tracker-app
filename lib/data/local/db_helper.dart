import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trackmint/data/model/expense_model.dart';
import 'package:trackmint/data/model/user_model.dart';
import 'package:trackmint/utill/app_constant.dart';

class DbHelper {
  DbHelper._();

  static DbHelper getInstance() => DbHelper._();
  Database? database;

// User Table
  static const String TABLE_USER = "user";
  static const String USER_ID = "u_id";
  static const String USER_NAME = "u_name";
  static const String USER_EMAIL = "u_email";
  static const String USER_PHONE = "u_phone";
  static const String USER_PASSWORD = "u_password";

// Expense Table
  static const String TABLE_EXPENSE = "expense";
  static const String EXPENSE_ID = "e_id";
  static const String EXPENSE_TITLE = "e_title";
  static const String EXPENSE_DESCRIPTION = "e_description";
  static const String EXPENSE_AMOUNT = "e_amount";
  static const String EXPENSE_BALANCE = "e_balance";
  static const String EXPENSE_CREATED_AT = "e_created_at";
  static const String EXPENSE_CATEGORY_ID = "e_category_id";
  static const String EXPENSE_TYPE = "e_type";

  Future<Database> initDB() async {
    if (database == null) {
      database = await createDB();
      return database!;
    }
    return database!;
    // alternate method
    // database ??= await createDB();
    //return database!;
  }

  Future<Database> createDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String path = join(appDir.path, "expensedb.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, version) {
      db.execute(''' CREATE TABLE $TABLE_USER(
      $USER_ID INTEGER PRIMARY KEY AUTOINCREMENT,
      $USER_NAME TEXT,
      $USER_EMAIL TEXT,
      $USER_PHONE TEXT,
      $USER_PASSWORD TEXT
      )
    ''');
      db.execute(''' CREATE TABLE $TABLE_EXPENSE(
      $EXPENSE_ID INTEGER PRIMARY KEY AUTOINCREMENT,
      $USER_ID INTEGER,
      $EXPENSE_TITLE TEXT,
      $EXPENSE_DESCRIPTION TEXT,
      $EXPENSE_AMOUNT INTEGER,
      $EXPENSE_BALANCE INTEGER,
      $EXPENSE_CREATED_AT TEXT,
      $EXPENSE_CATEGORY_ID INTEGER,
      $EXPENSE_TYPE INTEGER
      )
''');
    });
  }

// auth
  Future<bool> registerUser({required userModel}) async {
    var db = await initDB();
    int rowEffected = await db.insert(TABLE_USER, userModel.toMap());
    return rowEffected > 0;
  }

  Future<bool> isAlreadyEmailExist({required String email}) async {
    var db = await initDB();
    final result =
        await db.query(TABLE_USER, where: "$USER_EMAIL=?", whereArgs: [email]);

    return result.isNotEmpty;
  }

  Future<bool> checkEmailAndPasswordExist(
      {required String email, required String password}) async {
    var db = await initDB();

    List<Map<String, dynamic>> isUserExist = await db.query(TABLE_USER,
        columns: [USER_ID],
        where: "$USER_EMAIL=? AND $USER_PASSWORD=?",
        whereArgs: [email, password]);
    if (isUserExist.isNotEmpty) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setInt(AppConstant.TOKEN_KEY, isUserExist[0][USER_ID]);
    }
    return isUserExist.isNotEmpty;
  }

// expense

  Future<bool> insertExpnese({required ExpenseModel expenseModel}) async {
    final db = await initDB();

    int rowsEffected = await db.insert(TABLE_EXPENSE, expenseModel.toMap());
    // print("rowsEffected:${rowsEffected}");
    return rowsEffected > 0;
  }

  Future<List<ExpenseModel>> getExpenseData() async {
    final db = await initDB();
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    int uniqueUseId = sharedpref.getInt(AppConstant.TOKEN_KEY) ?? 0;
    List<Map<String, dynamic>> mapExpenseData = await db
        .query(TABLE_EXPENSE, where: "$USER_ID = ?", whereArgs: [uniqueUseId]);
    List<ExpenseModel> allExpenses = [];
    for (int i = 0; i < mapExpenseData.length; i++) {
      allExpenses.add(ExpenseModel.fromMap(mapExpenseData[i]));
    }

    return allExpenses;
  }

  // Future<List<ExpenseModel>> getAllExpenses() async {
  //   var db = await initDB();
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   int uid = prefs.getInt(AppConstant.TOKEN_KEY) ?? 0;

  //   List<Map<String, dynamic>> mData = await db
  //       .query(TABLE_EXPENSE, where: "$USER_ID = ?", whereArgs: ["$uid"]);
  //   List<ExpenseModel> allExp = [];

  //   for (int i = 0; i < mData.length; i++) {
  //     allExp.add(ExpenseModel.fromMap(mData[i]));
  //   }
  //   return allExp;
  // }
}
