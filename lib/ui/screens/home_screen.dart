import 'package:flutter/material.dart';
import 'package:trackmint/ui/screens/add_expense_screen.dart';
import 'package:trackmint/ui/screens/expense_screen.dart';
import 'package:trackmint/ui/screens/login_screen.dart';
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
    Center(
      child: LoginScreen(),
    ),
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
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insights_rounded),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Home",
          ),
        ],
        unselectedItemColor: Color(0xFF333333),
        selectedItemColor: Color(0xFFB0DB9C),
        currentIndex: selectedIndex,
        elevation: 4,
        onTap: (value) {
          selectedIndex = value;
          setState(() {});
        },
      ),
    );
  }
}
