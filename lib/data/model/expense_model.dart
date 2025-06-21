import 'package:trackmint/data/local/db_helper.dart';

class ExpenseModel {
  int? expenseId;
  int userId;
  String title;
  String description;
  num amount;
  num balance;
  int type;
  String createdAt;
  String categoryId;

  ExpenseModel({
    this.expenseId,
    required this.userId,
    required this.title,
    required this.description,
    required this.amount,
    required this.balance,
    required this.categoryId,
    required this.type,
    required this.createdAt,
  });

  // Map to model

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
        expenseId: map[DbHelper.EXPENSE_ID],
        userId: map[DbHelper.USER_ID],
        title: map[DbHelper.EXPENSE_TITLE],
        description: map[DbHelper.EXPENSE_DESCRIPTION],
        amount: map[DbHelper.EXPENSE_AMOUNT],
        balance: map[DbHelper.EXPENSE_BALANCE],
        categoryId: map[DbHelper.EXPENSE_CATEGORY_ID],
        type: map[DbHelper.EXPENSE_TYPE],
        createdAt: map[DbHelper.EXPENSE_CREATED_AT]);
  }

  // model to map

  Map<String, dynamic> toMap() {
    return {
      DbHelper.USER_ID: userId,
      DbHelper.EXPENSE_TITLE: title,
      DbHelper.EXPENSE_DESCRIPTION: description,
      DbHelper.EXPENSE_AMOUNT: amount,
      DbHelper.EXPENSE_BALANCE: balance,
      DbHelper.EXPENSE_CATEGORY_ID: categoryId,
      DbHelper.EXPENSE_CREATED_AT: createdAt,
      DbHelper.EXPENSE_TYPE: type
    };
  }
}
