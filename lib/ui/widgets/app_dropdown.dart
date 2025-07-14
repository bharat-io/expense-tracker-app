import 'package:flutter/material.dart';

class AppDropdown extends StatefulWidget {
  const AppDropdown({super.key, required this.onSelected});

  final ValueChanged<String?> onSelected;

  @override
  State<AppDropdown> createState() => _AppDropdownState();
}

class _AppDropdownState extends State<AppDropdown> {
  final List<String> dropDownItems = ["Date", "Month", "Year", "Category"];
  String selectedValue = "Date"; // Must match one of the items

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      width: 129,
      initialSelection: selectedValue,
      onSelected: widget.onSelected,
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.only(left: 9),
        filled: true,
        fillColor: Color(0xFFDDF6D2),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      dropdownMenuEntries: dropDownItems.map((e) {
        return DropdownMenuEntry(value: e, label: e);
      }).toList(),
    );
  }
}
