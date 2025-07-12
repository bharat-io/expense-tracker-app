import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackmint/bloc/expense_bloc/expense_bloc.dart';
import 'package:trackmint/bloc/expense_bloc/expense_event.dart';
import 'package:trackmint/bloc/expense_bloc/expense_state.dart';
import 'package:trackmint/ui/widgets/app_snackbar.dart';
import 'package:trackmint/ui/widgets/expense_list.dart';
import 'package:trackmint/utill/app_constant.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  String? userName;
  @override
  void initState() {
    super.initState();
    context.read<ExpenseBloc>().add(FetchExpenseEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "TrackMint",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            // fontStyle: FontStyle.italic,
            fontSize: 24,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.search,
              size: 35,
            ),
          )
        ],
      ),
      body: BlocBuilder<ExpenseBloc, ExpenseState>(builder: (context, state) {
        if (state is LoadingExpenseState) {
          return CircularProgressIndicator();
        } else if (state is LoadFaildState) {
          AppSnackbar.showSnackBar(context,
              contentText: Text(state.errorMessage));
        } else if (state is LoadedExpenseState) {
          return state.expenseModel.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 10, right: 16, left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildProfileCard(
                        profileUrl: "assets/images/profile_image.jpg",
                        context,
                        greetingText: "Good morning",
                        userName: userName!,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      _buildTotalExpenseCard(totalExpenseAmount: "4,000"),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        " Expense List",
                        style:
                            TextStyle(fontSize: 25, color: Color(0xFF333333)),
                      ),
                      Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.expenseModel.length,
                              itemBuilder: (context, index) {
                                final allExpenses = state.expenseModel[index];

                                return ExpenseListCard(
                                  spentDate: allExpenses.title,
                                  spentAmount: allExpenses.totalAmount,
                                  expeneseListData: allExpenses.expenseList,
                                );
                              }))
                    ],
                  ))
              : Text("NO data found");
        }
        return Container();
      }),
    );
  }

  Widget _buildProfileCard(BuildContext context,
      {required String profileUrl,
      required String greetingText,
      required String userName}) {
    return Container(
      child: Row(children: [
        CircleAvatar(
          backgroundImage: AssetImage(profileUrl),
          radius: 25,
        ),
        SizedBox(width: 8),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(greetingText,
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 15,
                  fontWeight: FontWeight.w100,
                  color: Color(0xFF333333))),
          Text(userName,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700))
        ]),
        Spacer(),
        _buildDropDown()
      ]),
    );
  }

  Widget _buildDropDown() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
          color: Color(0xFFDDF6D2), borderRadius: BorderRadius.circular(8)),
      child: Center(
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text("This month", style: TextStyle(fontSize: 15)),
          ),
          Icon(Icons.arrow_drop_down_outlined)
        ]),
      ),
    );
  }

  Widget _buildTotalExpenseCard({required String totalExpenseAmount}) {
    return Stack(
      children: [
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: Color(0xFFB0DB9C),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Expense Total",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w200,
                          color: Color(0xFF333333)),
                      // color: Color(0xFF333333)
                      // Color(0xFF2F5D50)
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text('₹$totalExpenseAmount',
                        style: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 29,
                            color: Color(0xFF333333))),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Color(0xFFDDF6D2),
                                borderRadius: BorderRadius.circular(4)),
                            child: Text(
                              "+₹250",
                              style: TextStyle(
                                  fontSize: 20, color: Color(0xFF333333)),
                            )),
                        Text("  than the last month",
                            style: TextStyle(
                                fontSize: 16, color: Color(0xFF333333))),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        Positioned(
            top: 20,
            right: -14,
            child: Image.asset("assets/images/graph.png", height: 122))
      ],
    );
  }
}
