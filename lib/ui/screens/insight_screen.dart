import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackmint/bloc/expense_bloc/expense_bloc.dart';
import 'package:trackmint/bloc/expense_bloc/expense_event.dart';
import 'package:trackmint/bloc/expense_bloc/expense_state.dart';
import 'package:trackmint/data/model/filtered_expense_model.dart';
import 'package:trackmint/ui/widgets/app_dropdown.dart';
import 'package:trackmint/ui/widgets/app_snackbar.dart';

class InsightScreen extends StatefulWidget {
  const InsightScreen({super.key});

  @override
  State<InsightScreen> createState() => _InsightScreenState();
}

class _InsightScreenState extends State<InsightScreen> {
  final List<String> dropDownItems = ["Date", "Month", "Year", "Category"];
  String selectedValue = "Date";
  int filterType = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              "Statistic",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF333333)),
            ),
            Spacer(),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTotalExpenseCard(totalExpenseAmount: "4,000"),
            SizedBox(
              height: 18,
            ),
            Row(
              children: [
                Text(
                  "Expense Breakdown",
                  style: TextStyle(fontSize: 20),
                ),
                Spacer(),
                AppDropdown(
                  initialSelection: selectedValue,
                  dropdownMenuEntries: dropDownItems.map((e) {
                    return DropdownMenuEntry(value: e, label: e);
                  }).toList(),
                  onSelected: (value) {
                    selectedValue = value!;
                    if (value == "Date") {
                      filterType = 1;
                    } else if (value == "Month") {
                      filterType = 2;
                    } else if (value == "Year") {
                      filterType = 3;
                    } else {
                      filterType = 4;
                    }

                    context
                        .read<ExpenseBloc>()
                        .add(FetchExpenseEvent(filterType: filterType));
                  },
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            BlocBuilder<ExpenseBloc, ExpenseState>(builder: (context, state) {
              if (state is LoadingExpenseState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is LoadFaildState) {
                AppSnackbar.showSnackBar(context,
                    contentText: state.errorMessage);
              }
              if (state is LoadedExpenseState) {
                List<FilteredExpenseModel> allExpenses = state.expenseModel;
                if (selectedValue == "Date") {
                  List<PieChartSectionData> allPieExpenseData = [];
                  for (int i = 0; i < allExpenses.length; i++) {
                    allPieExpenseData.add(PieChartSectionData(
                        color: Colors.primaries[i % Colors.primaries.length],
                        value: allExpenses[i].totalAmount < 0
                            ? allExpenses[i].totalAmount * -1.0
                            : allExpenses[i].totalAmount.toDouble()));
                  }
                  return SizedBox(
                    height: 250,
                    child: PieChart(
                      PieChartData(sections: allPieExpenseData),
                    ),
                  );
                } else {
                  List<BarChartGroupData> expenseBarData = [];
                  print(allExpenses);
                  for (int i = 0; i < allExpenses.length; i++) {
                    expenseBarData.add(
                      BarChartGroupData(x: i, barRods: [
                        _barRoadUi(
                            toY: allExpenses[i].totalAmount < 0
                                ? allExpenses[i].totalAmount * -1.0
                                : allExpenses[i].totalAmount.toDouble())
                      ]),
                    );
                  }

                  return SizedBox(
                    height: 250,
                    width: double.infinity,
                    child: BarChart(
                      BarChartData(
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  return Text(allExpenses[value.toInt()].title);
                                },
                              ),
                            ),
                          ),
                          barGroups: expenseBarData),
                    ),
                  );
                }
              }
              return Container();
            }),
            SizedBox(
              height: 10,
            ),
            Text(
              "Spending Details",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              "Your expenses are divided into 6 categories",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: 8,
            ),
            Divider(
              color: const Color.fromARGB(255, 230, 18, 212),
              thickness: 4,
            )
            // GridView.builder(gridDelegate: gridDelegate, itemBuilder: itemBuilder)
          ],
        ),
      ),
    );
  }
}

BarChartRodData _barRoadUi({required double toY}) {
  return BarChartRodData(
    toY: toY,
    width: 30,
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(6), topRight: Radius.circular(6)),
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
      // Positioned(
      //     top: 20,
      //     right: -14,
      //     child: Image.asset("assets/images/graph.png", height: 122))
    ],
  );
}
