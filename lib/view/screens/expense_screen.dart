import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trackmint/view/widgets/expense_list.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("TrackMint"),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileCard(
              context,
              greetingText: "Good morning",
              userName: "Rc.Johan",
            ),
            SizedBox(
              height: 16,
            ),
            _buildTotalExpenseCard(),
            SizedBox(
              height: 16,
            ),
            Text(
              " Expense List",
              style: TextStyle(fontSize: 25, color: Color(0xFF333333)),
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return ExpenseListCard(
                        spentDate: "TuesDay, 14",
                        spentAmount: 1500,
                        shoppingIcons: Icons.shopping_cart,
                        categoryText: "Cloths",
                        descriptionText: "jeans & T-shirts,shoes",
                        price: 1800,
                      );
                    }))
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context,
      {required String greetingText, required String userName}) {
    return Container(
      child: Row(
        children: [
          CircleAvatar(radius: 25),
          SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greetingText,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                userName,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
            ],
          ),
          Spacer(),
          _buildDropDown()
        ],
      ),
    );
  }

  Widget _buildDropDown() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
          color: Color(0xFFDDF6D2), borderRadius: BorderRadius.circular(8)),
      child: Center(
          child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "This month",
              style: TextStyle(fontSize: 15),
            ),
          ),
          Icon(Icons.arrow_drop_down_outlined),
        ],
      )),
    );
  }

  Widget _buildTotalExpenseCard() {
    return Card(
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
                  style: TextStyle(fontSize: 25, color: Color(0xFF333333)),
                  // color: Color(0xFF333333)
                  // Color(0xFF2F5D50)
                ),
                Text(
                  "₹4,000",
                  style: TextStyle(fontSize: 50, color: Color(0xFF333333)),
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
                        style:
                            TextStyle(fontSize: 20, color: Color(0xFF333333)),
                      ),
                    ),
                    Text(
                      "  than the last month",
                      style: TextStyle(fontSize: 18, color: Color(0xFF333333)),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
