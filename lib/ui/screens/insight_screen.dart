// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:trackmint/ui/widgets/app_dropdown.dart';

// class InsightScreen extends StatefulWidget {
//   const InsightScreen({super.key});

//   @override
//   State<InsightScreen> createState() => _InsightScreenState();
// }

// class _InsightScreenState extends State<InsightScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           children: [
//             Text(
//               "Statistic",
//               style: TextStyle(
//                   fontSize: 30,
//                   fontWeight: FontWeight.w400,
//                   color: Color(0xFF333333)),
//             ),
//             Spacer(),
//             AppDropdown(),
//           ],
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildTotalExpenseCard(totalExpenseAmount: "4,000"),
//             SizedBox(
//               height: 18,
//             ),
//             Row(
//               children: [
//                 Text(
//                   "Expense Breakdown",
//                   style: TextStyle(fontSize: 20),
//                 ),
//                 Spacer(),
//                 AppDropdown()
//               ],
//             ),
//             SizedBox(
//               height: 250,
//             ),
//             Text(
//               "Spending Details",
//               style: TextStyle(fontSize: 20),
//             ),
//             SizedBox(
//               height: 4,
//             ),
//             Text(
//               "Your expenses are divided into 6 categories",
//               style: TextStyle(fontSize: 15),
//             ),
//             SizedBox(
//               height: 8,
//             ),
//             Divider(
//               color: const Color.fromARGB(255, 230, 18, 212),
//               thickness: 4,
//             )
//             GridView.builder(gridDelegate: gridDelegate, itemBuilder: itemBuilder)
//           ],
//         ),
//       ),
//     );
//   }
// }

// Widget _buildTotalExpenseCard({required String totalExpenseAmount}) {
//   return Stack(
//     children: [
//       Card(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         color: Color(0xFFB0DB9C),
//         child: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Row(
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Expense Total",
//                     style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w200,
//                         color: Color(0xFF333333)),
//                     // color: Color(0xFF333333)
//                     // Color(0xFF2F5D50)
//                   ),
//                   SizedBox(
//                     height: 3,
//                   ),
//                   Text('₹$totalExpenseAmount',
//                       style: TextStyle(
//                           fontWeight: FontWeight.w100,
//                           fontSize: 29,
//                           color: Color(0xFF333333))),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Row(
//                     children: [
//                       Container(
//                           padding: EdgeInsets.all(5),
//                           decoration: BoxDecoration(
//                               color: Color(0xFFDDF6D2),
//                               borderRadius: BorderRadius.circular(4)),
//                           child: Text(
//                             "+₹250",
//                             style: TextStyle(
//                                 fontSize: 20, color: Color(0xFF333333)),
//                           )),
//                       Text("  than the last month",
//                           style: TextStyle(
//                               fontSize: 16, color: Color(0xFF333333))),
//                     ],
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//       // Positioned(
//       //     top: 20,
//       //     right: -14,
//       //     child: Image.asset("assets/images/graph.png", height: 122))
//     ],
//   );
// }
