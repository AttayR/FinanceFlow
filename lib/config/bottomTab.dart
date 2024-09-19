import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:manage_loan/styles/colors.dart';

class BottomTabNavigator extends StatefulWidget {
  final Widget child;
  const BottomTabNavigator({super.key, required this.child});
  @override
  _BottomTabNavigatorState createState() => _BottomTabNavigatorState();
}

class _BottomTabNavigatorState extends State<BottomTabNavigator> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          GoRouter.of(context).go('/loan_dashbord');
          break;
        case 1:
          GoRouter.of(context).go('/add_loan');
          break;
        case 2:
          GoRouter.of(context).go('/view_loan');
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add New Loan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Loan History',
          ),
        ],
        currentIndex: _selectedIndex,
        backgroundColor: primaryColor,
        selectedItemColor: whiteColor, 
        unselectedItemColor: blackColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
