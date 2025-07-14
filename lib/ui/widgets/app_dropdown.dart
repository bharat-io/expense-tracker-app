import 'package:flutter/material.dart';

class AppDropdown extends StatefulWidget {
  const AppDropdown(
      {super.key,
      required this.onSelected,
      required this.dropdownMenuEntries,
      required this.initialSelection});

  final ValueChanged<String?> onSelected;
  final String initialSelection;
  final List<DropdownMenuEntry<String>> dropdownMenuEntries;

  @override
  State<AppDropdown> createState() => _AppDropdownState();
}

class _AppDropdownState extends State<AppDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
        width: 129,
        initialSelection: widget.initialSelection,
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
        dropdownMenuEntries: widget.dropdownMenuEntries);
  }
}
