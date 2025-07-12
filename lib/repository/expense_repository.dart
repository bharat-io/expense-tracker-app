import 'package:flutter/gestures.dart';
import 'package:intl/intl.dart';
import 'package:trackmint/data/local/db_helper.dart';
import 'package:trackmint/data/model/expense_model.dart';
import 'package:trackmint/data/model/filtered_expense_model.dart';

class ExpenseRepository {
  DbHelper dbHelper;
  ExpenseRepository({required this.dbHelper});

  Future<bool> addExpneseData({required ExpenseModel expenseModel}) async {
    bool check = await dbHelper.insertExpnese(expenseModel: expenseModel);
    // print(check);
    return check;
  }

  Future<List<FilteredExpenseModel>> fetchExpenseData() async {
    final allExpenses = await dbHelper.getExpenseData();
    //date formate
    List<FilteredExpenseModel> allfilterExpnese = [];
    DateFormat dateFormat = DateFormat.yMMMEd();

    //datewise
    List<String> uniqueDates = [];

    for (ExpenseModel eachExpense in allExpenses) {
      String eachDate = dateFormat.format(DateTime.fromMillisecondsSinceEpoch(
          int.parse(eachExpense.createdAt)));
      if (!uniqueDates.contains(eachDate)) {
        uniqueDates.add(eachDate);
      }
    }
    print(uniqueDates);
    for (String eachDate in uniqueDates) {
      num totalAmount = 0.0;
      List<ExpenseModel> allExpenseByDate = [];

      for (ExpenseModel eachExpense in allExpenses) {
        String expneseDate = dateFormat.format(
            DateTime.fromMillisecondsSinceEpoch(
                int.parse(eachExpense.createdAt)));
        if (eachDate == expneseDate) {
          allExpenseByDate.add(eachExpense);
          if (eachExpense.type == 1) {
            //debit

            totalAmount = totalAmount + eachExpense.amount;
          } else {
            totalAmount = totalAmount - eachExpense.amount;
          }
        }
      }
      allfilterExpnese.add(FilteredExpenseModel(
          title: eachDate,
          totalAmount: totalAmount,
          expenseList: allExpenseByDate));
    }

    return allfilterExpnese;
  }
}
