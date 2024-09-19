import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:manage_loan/config/extension.dart';
import 'package:manage_loan/enum/enums.dart';
import 'package:manage_loan/screens/dashbord/local_widget/loan_info_card.dart';
import 'package:manage_loan/screens/edit_financial_summary.dart';
import 'package:manage_loan/styles/colors.dart';
import 'package:manage_loan/styles/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoanDashbord extends StatefulWidget {
  const LoanDashbord({super.key});

  @override
  State<LoanDashbord> createState() => _LoanDashbordState();
}

class _LoanDashbordState extends State<LoanDashbord> {
  String? loansGiven = '0';
  String? loansReceived = '0';
  String? netBalance = '0';
  String? _userName;
  List<Map<String, String>> pendingLoans = [];

  @override
  void initState() {
    super.initState();
    _loadLoans();
    _loadUserName();
    _loadFinancialSummary();
  }

  Future<void> _loadFinancialSummary() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      loansGiven = prefs.getString('loansGiven') ?? '0';
      loansReceived = prefs.getString('loansReceived') ?? '0';
      netBalance = prefs.getString('netBalance') ?? '0';
    });
  }

  Future<void> _loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('userName');
    });
  }

  Future<void> _loadLoans() async {
    final prefs = await SharedPreferences.getInstance();
    final loanDataString = prefs.getString('loanData') ?? '[]';

    try {
      final List<dynamic> decodedData = jsonDecode(loanDataString);
      setState(() {
        pendingLoans = List<Map<String, String>>.from(
          decodedData.map((loan) => Map<String, String>.from(loan)),
        );
      });
    } catch (e) {
      setState(() {
        pendingLoans = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          _userName != null ? 'Hello, $_userName!' : 'Loan Dashboard',
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                context.push('/search_loan');
              },
              icon: const Icon(Icons.search))
        ],
        iconTheme: const IconThemeData(
          color: whiteColor,
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: whiteColor,
                    backgroundImage: AssetImage(
                        'assets/images/logo.png'), // Replace with your image path
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'FinanceFlow',
                    style: AppTheme.headerStyle(color: whiteColor),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildDrawerItem(
                    icon: Icons.dashboard,
                    text: 'Loan Dashboard',
                    onTap: () {
                      Navigator.pop(context);
                      context.push('/loan_dashbord');
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.add,
                    text: 'Add Loan',
                    onTap: () {
                      Navigator.pop(context);
                      context.push('/add_loan');
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.visibility,
                    text: 'Loan History',
                    onTap: () {
                      Navigator.pop(context);
                      context.push('/view_loan');
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.policy,
                    text: 'Privacy Policy',
                    onTap: () {
                      Navigator.pop(context);
                      context.push('/privacy_policy');
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.settings,
                    text: 'Edit Finance Summary',
                    onTap: () {
                      Navigator.pop(context);
                      context.push('/edit_financial_summary');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _userName != null
                  ? 'Welcome to your Loan Dashboard!'
                  : 'Welcome to your Loan Dashboard',
              style: AppTheme.titleStyle(
                color: blackColor,
              ),
              textAlign: TextAlign.center,
            ),
            20.height(),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
                gradient: const LinearGradient(
                  colors: [Color.fromRGBO(0, 150, 136, 1.0), Colors.white12],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Financial Summary',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow('Loans Given Out', loansGiven ?? '',
                      Icons.arrow_upward, Colors.redAccent),
                  _buildInfoRow('Loans Received', loansReceived ?? '',
                      Icons.arrow_downward, Colors.green),
                  Divider(color: Colors.grey[300], thickness: 1),
                  const SizedBox(height: 16),
                  Center(
                    child: Column(
                      children: [
                        const Text('Net Balance',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        Text('\$ $netBalance',
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            30.height(),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditFinancialSummaryScreen()),
                  );
                  _loadFinancialSummary();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(0, 150, 136, 1.0),
                ),
                child: const Text(
                  'Edit Financial Summary',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            10.height(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    'Loans',
                    style: AppTheme.headerStyle(
                      color: blackColor,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    children: pendingLoans.isEmpty
                        ? [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: Text(
                                'No pending loans available.',
                                style: AppTheme.titleStyle(
                                  color: Colors.grey[600]!,
                                ),
                              ),
                            ),
                          ]
                        : pendingLoans.map((loan) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: LoanInfoCard(
                                loanAmount: loan['loanAmount'] ?? '',
                                loanName: loan['loanName'] ?? '',
                                loanType: LoanType.values.firstWhere(
                                  (e) => e.name == loan['loanType'],
                                  orElse: () => LoanType.LoanGivenByMe,
                                ),
                                fullName: loan['fullName'] ?? '',
                                incurredDate: loan['incurredDate'] ?? '',
                                isLoaned: true,
                                onTap: () {
                                  context.push('/view_loan');
                                },
                              ),
                            );
                          }).toList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: primaryColor),
      title: Text(text, style: AppTheme.titleStyle(color: blackColor)),
      onTap: onTap,
    );
  }

  Row _buildInfoRow(
      String title, String amount, IconData icon, Color iconColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
        Icon(icon, color: iconColor, size: 24),
        const SizedBox(width: 8),
        Text(
          '\$ $amount',
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
