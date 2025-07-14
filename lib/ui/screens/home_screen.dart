import 'package:flutter/material.dart';
import 'package:trackmint/ui/screens/add_expense_screen.dart';
import 'package:trackmint/ui/screens/expense_screen.dart';
import 'package:trackmint/ui/screens/insight_screen.dart';
import 'package:trackmint/ui/screens/setting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> pages = [
    ExpenseScreen(),
    InsightScreen(),
    AddExpenseScreen(),
    Center(
      child: Text("Notification page"),
    ),
    SettingScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_filled),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            label: "Insights",
          ),
          BottomNavigationBarItem(
            icon: Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Color(0xFFB0DB9C),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.add,
                  color: Color(0xFF333333),
                  size: 32,
                )),
            label: "Add",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none_outlined),
            activeIcon: Icon(Icons.notifications),
            label: "Notifi",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: "setting",
          ),
        ],
        unselectedItemColor: Color(0xFF333333),
        selectedItemColor: Color(0xFFB0DB9C),
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        elevation: 4,
        onTap: (value) {
          selectedIndex = value;
          setState(() {});
        },
      ),
    );
  }
}
