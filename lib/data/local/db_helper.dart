import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trackmint/data/model/expense_model.dart';

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
      $EXPENSE_ID INTEGER PRIMARY AUTOINCREMENR,
      $EXPENSE_TITLE TEXT,
      $EXPENSE_DESCRIPTION TEXT,
      $EXPENSE_AMOUNT TEXT,
      $EXPENSE_BALANCE TEXT,
      $EXPENSE_CREATED_AT TEXT,
      $EXPENSE_CATEGORY_ID TEXT,
      $EXPENSE_TYPE TEXT
      )
''');
    });
  }

// auth
  Future registerUser({required userModel}) async {
    var db = await initDB();
    db.insert(TABLE_USER, userModel.toMap);
  }

// expense

  Future<List<ExpenseModel>> fetchData() async {
    var db = await initDB();
    List<ExpenseModel> expenseList = [];
    List<Map<String, dynamic>> expenseMapData;
    expenseMapData = await db.query(TABLE_EXPENSE);
    for (int i = 0; i < expenseMapData.length; i++) {
      ExpenseModel expenseModel = ExpenseModel.fromMap(expenseMapData[i]);
      expenseList.add(expenseModel);
    }
    return expenseList;
  }

  Future<bool> addData({required expenseModel}) async {
    var db = await initDB();
    int rowEffect = await db.insert(TABLE_EXPENSE, expenseModel.toMap);
    return rowEffect > 0;
  }
}
