import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackmint/bloc/expense_bloc/expense_bloc.dart';
import 'package:trackmint/bloc/expense_bloc/expense_event.dart';
import 'package:trackmint/bloc/expense_bloc/expense_state.dart';
import 'package:trackmint/data/model/expense_model.dart';
import 'package:trackmint/ui/widgets/app_snackbar.dart';
import 'package:trackmint/utill/app_constant.dart';
import 'package:trackmint/utill/app_routes.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  int _selectedCategory = -1;

  final List<String> _expensetype = ["credit", "debit"];
  final String _selectedType = "debit";
  bool isLoading = false;

  void pickDate() async {
    final picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2024),
        lastDate: DateTime.now());

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void submitExpense() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Expense")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFDDF6D2),
                  hintText: "Title",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFDDF6D2),
                  hintText: "Amount",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFDDF6D2),
                  hintText: "Description",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    backgroundColor: Color(0xFFDDF6D2),
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: BorderSide.none),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4),
                            itemCount: AppConstant.categoryList.length,
                            itemBuilder: (context, index) {
                              var categoryList =
                                  AppConstant.categoryList[index];
                              return InkWell(
                                onTap: () {
                                  _selectedCategory = index;
                                  setState(() {});
                                  Navigator.of(context).pop();
                                },
                                child: Column(
                                  children: [
                                    Image.asset(
                                      categoryList.cagtegoryImage,
                                      width: 35,
                                    ),
                                    Text(categoryList.categoryName)
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      });
                },
                child: _selectedCategory < 0
                    ? Text("Select Category")
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppConstant
                                .categoryList[_selectedCategory].cagtegoryImage,
                            width: 35,
                          ),
                          Text(AppConstant
                              .categoryList[_selectedCategory].categoryName),
                        ],
                      ),
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Type", style: TextStyle(fontSize: 12)),
                        DropdownMenu(
                            initialSelection: _selectedType,
                            width: 150,
                            inputDecorationTheme: InputDecorationTheme(
                                contentPadding: EdgeInsets.only(left: 35),
                                filled: true,
                                fillColor: Color(0xFFDDF6D2),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none)),
                            dropdownMenuEntries: _expensetype.map((e) {
                              return DropdownMenuEntry(value: e, label: e);
                            }).toList()),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Date", style: TextStyle(fontSize: 12)),
                        InkWell(
                          onTap: pickDate,
                          child: Container(
                            height: 55,
                            padding: const EdgeInsets.only(
                                left: 29, right: 12, bottom: 10, top: 10),
                            decoration: BoxDecoration(
                              color: Color(0xFFDDF6D2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${_selectedDate.toLocal()}".split(' ')[0],
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const Icon(Icons.calendar_today, size: 18),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              // const Spacer(),
              BlocListener<ExpenseBloc, ExpenseState>(
                listener: (context, state) {
                  if (state is LoadFaildState) {
                    AppSnackbar.showSnackBar(context,
                        contentText: Text(state.errorMessage));
                  } else if (state is LoadedExpenseState) {
                    Navigator.pop(context, true);
                  }
                },
                child: ElevatedButton(
                  onPressed: () async {
                    final hasAlphabet =
                        RegExp(r'[a-zA-Z]').hasMatch(_titleController.text);

                    if (_titleController.text.isEmpty ||
                        _amountController.text.isEmpty ||
                        _descriptionController.text.isEmpty) {
                      AppSnackbar.showSnackBar(context,
                          contentText: "Please fill the fields properly");
                    } else if (!hasAlphabet) {
                      AppSnackbar.showSnackBar(context,
                          contentText: "Please enter valid title");
                    } else if (_selectedCategory <= 0) {
                      AppSnackbar.showSnackBar(context,
                          contentText: "Plese select category");
                    } else {
                      SharedPreferences sharedPreferences =
                          await SharedPreferences.getInstance();
                      int userId =
                          sharedPreferences.getInt(AppConstant.TOKEN_KEY) ?? 0;

                      context.read<ExpenseBloc>().add(AddExpenseEvent(
                          expenseModel: ExpenseModel(
                              userId: userId,
                              title: _titleController.text,
                              description: _descriptionController.text,
                              amount: double.parse(_amountController.text),
                              balance: 0,
                              categoryId: AppConstant
                                  .categoryList[_selectedCategory].categoryId,
                              type: _selectedType == "debit" ? 1 : 2,
                              createdAt: (_selectedDate)
                                  .millisecondsSinceEpoch
                                  .toString())));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(45),
                    backgroundColor: Color(0xFFB0DB9C),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Add Expense",
                    style: TextStyle(fontSize: 16, color: Color(0xFF333333)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
