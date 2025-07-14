import 'package:flutter/gestures.dart';
import 'package:intl/intl.dart';
import 'package:trackmint/data/local/db_helper.dart';
import 'package:trackmint/data/model/category_model.dart';
import 'package:trackmint/data/model/expense_model.dart';
import 'package:trackmint/data/model/filtered_expense_model.dart';
import 'package:trackmint/utill/app_constant.dart';

class ExpenseRepository {
  DbHelper dbHelper;

  ExpenseRepository({required this.dbHelper});

  Future<bool> addExpneseData({required ExpenseModel expenseModel}) async {
    bool check = await dbHelper.insertExpnese(expenseModel: expenseModel);
    return check;
  }

  Future<List<FilteredExpenseModel>> fetchExpenseData({
    int filterType = 1,
  }) async {
    ///1-> date wise, 2-> month wise, 3-> year wise, 4-> cat wise
    var allExp = await dbHelper.getExpenseData();

    List<FilteredExpenseModel> mFilteredExp = [];
    DateFormat df = DateFormat.y();

    if (filterType <= 3) {
      if (filterType == 1) {
        df = DateFormat.yMMMEd();
      } else if (filterType == 2) {
        df = DateFormat.yMMM();
      } else {
        df = DateFormat.y();
      }

      ///date wise
      ///1
      List<String> uniqueDates = [];

      for (ExpenseModel eachExp in allExp) {
        String eachDate = df.format(
          DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp.createdAt)),
        );

        if (!uniqueDates.contains(eachDate)) {
          uniqueDates.add(eachDate);
        }
      }
      print(uniqueDates);

      ///2
      for (String eachDate in uniqueDates) {
        num totalAmt = 0.0;
        List<ExpenseModel> mExpByDate = [];

        for (ExpenseModel eachExp in allExp) {
          String expDate = df.format(
            DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp.createdAt)),
          );

          if (eachDate == expDate) {
            mExpByDate.add(eachExp);

            if (eachExp.type == 1) {
              ///debit
              totalAmt -= eachExp.amount;
            } else {
              ///credit
              totalAmt += eachExp.amount;
            }
          }
        }

        mFilteredExp.add(FilteredExpenseModel(
            title: eachDate, totalAmount: totalAmt, expenseList: mExpByDate));
      }

      print(mFilteredExp.length);
    } else {
      /// cat wise

      for (CategoryModel eachCat in AppConstant.categoryList) {
        num totalAmt = 0.0;
        List<ExpenseModel> mExpByCat = [];

        for (ExpenseModel eachExp in allExp) {
          if (eachCat.categoryId == eachExp.categoryId) {
            mExpByCat.add(eachExp);

            if (eachExp.type == 1) {
              totalAmt -= eachExp.amount;
            } else {
              totalAmt += eachExp.amount;
            }
          }
        }

        if (mExpByCat.isNotEmpty) {
          mFilteredExp.add(FilteredExpenseModel(
              title: eachCat.categoryName,
              totalAmount: totalAmt,
              expenseList: mExpByCat));
        }
      }
    }

    return mFilteredExp;
  }
}

///update
///delete

// class ExpenseRepository {
//   DbHelper dbHelper;
//   ExpenseRepository({required this.dbHelper});

//   Future<bool> addExpneseData({required ExpenseModel expenseModel}) async {
//     bool check = await dbHelper.insertExpnese(expenseModel: expenseModel);
//     // print(check);
//     return check;
//   }

//   Future<List<FilteredExpenseModel>> fetchExpenseData(
//       {int filterType = 1}) async {
//     final allExpenses = await dbHelper.getExpenseData();

//     List<FilteredExpenseModel> allfilterExpnese = [];
//     DateFormat df = DateFormat.yMMMEd();
//     if (filterType <= 3) {
//       if (filterType == 1) {
//         df = DateFormat.yMMMEd();
//       } else if (filterType == 2) {
//         df = DateFormat.yMMM();
//       } else {
//         df = DateFormat.y();
//       }
//       List<String> uniqueDates = [];

//       for (ExpenseModel eachExpense in allExpenses) {
//         String eachDate = df.format(DateTime.fromMillisecondsSinceEpoch(
//             int.parse(eachExpense.createdAt)));
//         if (!uniqueDates.contains(eachDate)) {
//           uniqueDates.add(eachDate);
//         }
//       }
//       print(uniqueDates);
//       for (String eachDate in uniqueDates) {
//         num totalAmount = 0.0;
//         List<ExpenseModel> allExpenseByDate = [];

//         for (ExpenseModel eachExpense in allExpenses) {
//           String expneseDate = df.format(DateTime.fromMillisecondsSinceEpoch(
//               int.parse(eachExpense.createdAt)));
//           if (eachDate == expneseDate) {
//             allExpenseByDate.add(eachExpense);
//             if (eachExpense.type == 1) {
//               //debit

//               totalAmount = totalAmount + eachExpense.amount;
//             } else {
//               totalAmount = totalAmount - eachExpense.amount;
//             }
//           }
//         }
//       }
//     } else {
//       //catWise
//       for (CategoryModel eachCate in AppConstant.categoryList) {
//         num totalamt = 0.0;
//         List<ExpenseModel> expenseByCat = [];
//         for (ExpenseModel eachExpense in allExpenses) {
//           if (eachCate.categoryId == eachExpense.categoryId) {
//             expenseByCat.add(eachExpense);

//             if (eachExpense.type == 1) {
//               totalamt -= eachExpense.amount;
//             } else {
//               totalamt += eachExpense.amount;
//             }
//           }
//         }
//         if (expenseByCat.isNotEmpty) {
//           allfilterExpnese.add(FilteredExpenseModel(
//               title: eachCate.categoryName,
//               totalAmount: totalamt,
//               expenseList: expenseByCat));
//         }
//       }
//     }

//     return allfilterExpnese;
//   }
// }
