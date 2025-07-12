import 'package:trackmint/data/model/expense_model.dart';
import 'package:trackmint/data/model/filtered_expense_model.dart';

abstract class ExpenseState {}

class InitialExpenseState extends ExpenseState {}

class LoadingExpenseState extends ExpenseState {}

class LoadedExpenseState extends ExpenseState {
  List<FilteredExpenseModel> expenseModel;
  LoadedExpenseState({required this.expenseModel});
}

class LoadFaildState extends ExpenseState {
  String errorMessage;
  LoadFaildState({required this.errorMessage});
}
