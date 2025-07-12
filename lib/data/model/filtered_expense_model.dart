import 'package:trackmint/data/model/expense_model.dart';

class FilteredExpenseModel {
  String title;
  num totalAmount;
  List<ExpenseModel> expenseList;
  FilteredExpenseModel(
      {required this.title,
      required this.totalAmount,
      required this.expenseList});
}
