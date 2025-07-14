import 'package:trackmint/data/model/expense_model.dart';

abstract class ExpenseEvent {}

class AddExpenseEvent extends ExpenseEvent {
  ExpenseModel expenseModel;
  AddExpenseEvent({required this.expenseModel});
}

class FetchExpenseEvent extends ExpenseEvent {
  int filterType;
  FetchExpenseEvent({this.filterType = 1});
}
