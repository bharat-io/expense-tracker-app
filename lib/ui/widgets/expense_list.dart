import 'dart:math';

import 'package:flutter/material.dart';
import 'package:trackmint/data/model/expense_model.dart';
import 'package:trackmint/utill/app_constant.dart';

class ExpenseListCard extends StatelessWidget {
  ExpenseListCard({
    super.key,
    required this.spentDate,
    required this.spentAmount,
    required this.expeneseListData,
  });
  final String spentDate;
  final num spentAmount;
  List<ExpenseModel> expeneseListData = [];

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFF2F2F2),
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            /// Expense List Header Row..
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  spentDate,
                  style: TextStyle(fontSize: 22, color: Color(0xFF333333)),
                ),
                Text(
                  '-₹${spentAmount.toString()}',
                  style: TextStyle(fontSize: 22, color: Color(0xFF333333)),
                ),
              ],
            ),

            const Divider(height: 25),
            SizedBox(
              width: double.infinity,
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: expeneseListData.length,
                  itemBuilder: (context, index) {
                    String imageUrl = AppConstant.categoryList
                        .where((e) {
                          return e.categoryId ==
                              expeneseListData[index].categoryId;
                        })
                        .toList()[0]
                        .cagtegoryImage;
                    final expenses = expeneseListData[index];
                    return _buildExpensesItem(context,
                        imagePath: imageUrl,
                        title: expenses.title,
                        description: expenses.description,
                        amount: expenses.amount);
                  }),
            ),

            // _buildExpensesItem(
            //   context,
            //   icon: Icons.electrical_services_outlined,
            //   iconBgColor: Color(0xFFFFD6D6),
            //   category: "Electronics",
            //   description: "Headphones",
            //   amount: 799,
            // ),
            // _buildExpensesItem(
            //   context,
            //   icon: Icons.fastfood_rounded,
            //   iconBgColor: Color(0xFFFFE7C7),
            //   category: "Food",
            //   description: "Snacks & Drinks",
            //   amount: 310,
            // ),
          ],
        ),
      ),
    );
  }
}

Widget _buildExpensesItem(BuildContext context,
    {required String imagePath,
    required String title,
    required String description,
    required num amount}) {
  const textColor = Color(0xFF333333);

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      children: [
        Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors
                  .primaries[Random().nextInt(Colors.accents.length)].shade100,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Image.asset(
              imagePath,
              width: 30,
            )),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 22, color: textColor),
            ),
            Text(
              description,
              style: const TextStyle(fontSize: 14, color: textColor),
            ),
          ],
        ),
        const Spacer(),
        Text(
          "-₹${amount.toStringAsFixed(0)}",
          style: const TextStyle(fontSize: 18, color: textColor),
        ),
      ],
    ),
  );
}
