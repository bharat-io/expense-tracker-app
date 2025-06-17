import 'package:flutter/material.dart';

class ExpenseListCard extends StatelessWidget {
  const ExpenseListCard({super.key});

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
            /// Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Tuesday, 14",
                  style: TextStyle(fontSize: 22, color: Color(0xFF333333)),
                ),
                Text(
                  "-₹1500",
                  style: TextStyle(fontSize: 22, color: Color(0xFF333333)),
                ),
              ],
            ),

            const Divider(height: 25),
            _buildExpensesItem(
              context,
              icon: Icons.shopping_cart,
              iconBgColor: Color(0xFFD1F5FF),
              category: "Groceries",
              description: "Fruits & Vegetables",
              amount: 391,
            ),

            _buildExpensesItem(
              context,
              icon: Icons.electrical_services_outlined,
              iconBgColor: Color(0xFFFFD6D6),
              category: "Electronics",
              description: "Headphones",
              amount: 799,
            ),
            _buildExpensesItem(
              context,
              icon: Icons.fastfood_rounded,
              iconBgColor: Color(0xFFFFE7C7),
              category: "Food",
              description: "Snacks & Drinks",
              amount: 310,
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildExpensesItem(BuildContext context,
    {required IconData icon,
    required Color iconBgColor,
    required String category,
    required String description,
    required double amount}) {
  const textColor = Color(0xFF333333);

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconBgColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(
            icon,
            size: 30,
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category,
              style: const TextStyle(fontSize: 18, color: textColor),
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
