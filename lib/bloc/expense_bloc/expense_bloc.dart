import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackmint/bloc/expense_bloc/expense_event.dart';
import 'package:trackmint/bloc/expense_bloc/expense_state.dart';
import 'package:trackmint/data/model/expense_model.dart';
import 'package:trackmint/data/model/filtered_expense_model.dart';
import 'package:trackmint/repository/expense_repository.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  ExpenseRepository expenseRepository;
  ExpenseBloc({required this.expenseRepository})
      : super(InitialExpenseState()) {
    on<AddExpenseEvent>(
      (event, emit) async {
        emit(LoadingExpenseState());
        bool check = await expenseRepository.addExpneseData(
            expenseModel: event.expenseModel);

        if (check) {
          List<FilteredExpenseModel> expenseModel =
              await expenseRepository.fetchExpenseData();
          emit(LoadedExpenseState(expenseModel: expenseModel));
          print("success state emited ${expenseModel}");
        } else {
          emit(LoadFaildState(errorMessage: "Expense not added!"));
        }
      },
    );
    on<FetchExpenseEvent>(
      (event, emit) async {
        emit(LoadingExpenseState());
        List<FilteredExpenseModel> expenseModel =
            await expenseRepository.fetchExpenseData();
        emit(LoadedExpenseState(expenseModel: expenseModel));
      },
    );
  }
}
