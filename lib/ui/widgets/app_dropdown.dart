import 'package:flutter/material.dart';

class AppDropdown extends StatefulWidget {
  const AppDropdown({super.key});

  @override
  State<AppDropdown> createState() => _AppDropdownState();
}

class _AppDropdownState extends State<AppDropdown> {
  final List<String> dropDownItems = [
    "Today",
    "This month",
    "Last year",
    "Last Week"
  ];
  String selectedValue = "Today"; // must match an item in dropDownItems

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 35,
      decoration: BoxDecoration(
          color: Color(0xFFDDF6D2), borderRadius: BorderRadius.circular(6)),
      child: DropdownButton<String>(
        padding: EdgeInsets.only(left: 15),
        value: selectedValue,
        items: dropDownItems.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            setState(() {
              selectedValue = value;
            });
          }
        },
      ),
    );
  }
}
