// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_text_form_field/flutter_text_form_field.dart';
// import 'package:manage_loan/config/extension.dart';
// import 'package:manage_loan/screens/dashbord/local_widget/loan_info_card.dart';
// import 'package:manage_loan/styles/colors.dart';
// import 'package:manage_loan/styles/theme.dart';
// import 'package:manage_loan/enum/enums.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SearchLoanScreen extends StatefulWidget {
//   const SearchLoanScreen({super.key});

//   @override
//   State<SearchLoanScreen> createState() => _SearchLoanScreenState();
// }

// class _SearchLoanScreenState extends State<SearchLoanScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   String _searchQuery = '';
//   List<Map<String, String>> _loanList = [];
//   List<Map<String, String>> _filteredLoans = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadLoans();
//     _searchController.addListener(_filterLoans);
//   }
  
//   Future<void> _loadLoans() async {
//     final prefs = await SharedPreferences.getInstance();
//     final loanDataString = prefs.getString('loanData') ?? '[]';

//     try {
//       final List<dynamic> decodedData = jsonDecode(loanDataString);
//       setState(() {
//         _loanList = List<Map<String, String>>.from(
//           decodedData.map((loan) => Map<String, String>.from(loan)),
//         );
//         _filteredLoans = _loanList; 
//       });
//     } catch (e) {
//       print('Error loading loans: $e');
//       setState(() {
//         _loanList = [];
//         _filteredLoans = [];
//       });
//     }
//   }

//   void _filterLoans() {
//     final query = _searchController.text.toLowerCase();
//     setState(() {
//       _searchQuery = query;
//       _filteredLoans = _loanList.where((loan) {
//         final loanName = loan['loanName']?.toLowerCase() ?? '';
//         return loanName.contains(_searchQuery);
//       }).toList();
//     });
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: primaryColor,
//         title: Text(
//           'Search Loan',
//           style: AppTheme.headerStyle(color: whiteColor),
//         ),
//         iconTheme: const IconThemeData(
//           color: whiteColor, 
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             CustomTextField(
//               _searchController,
//               hint: 'Enter Loan Name',
//               password: false,
//               border: Border.all(color: greyColor),
//             ),
//             20.height(),
//             Expanded(
//               child: GridView.builder(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   mainAxisSpacing: 10,
//                   crossAxisSpacing: 10,
//                 ),
//                 itemCount: _filteredLoans.length,
//                 itemBuilder: (context, index) {
//                   final loan = _filteredLoans[index];
//                   final loanType = LoanType.values.firstWhere(
//                     (e) => e.name == loan['loanType'],
//                     orElse: () => LoanType.LoanGivenByMe,
//                   );
//                   return LoanInfoCard(
//                     loanName: loan['loanName'] ?? '',
//                     fullName: loan['fullName'] ?? '',
//                     loanAmount: loan['loanAmount'] ?? '',
//                     incurredDate: loan['incurredDate'] ?? '',
//                     isLoaned: true,
//                     loanType: loanType,
//                     onTap: () {
//                       // Handle tap, maybe show loan details
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_text_form_field/flutter_text_form_field.dart';
import 'package:manage_loan/config/extension.dart';
import 'package:manage_loan/screens/dashbord/local_widget/loan_info_card.dart';
import 'package:manage_loan/styles/colors.dart';
import 'package:manage_loan/styles/theme.dart';
import 'package:manage_loan/enum/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchLoanScreen extends StatefulWidget {
  const SearchLoanScreen({super.key});

  @override
  State<SearchLoanScreen> createState() => _SearchLoanScreenState();
}

class _SearchLoanScreenState extends State<SearchLoanScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<Map<String, String>> _loanList = [];
  List<Map<String, String>> _filteredLoans = [];

  @override
  void initState() {
    super.initState();
    _loadLoans();
    _searchController.addListener(_filterLoans);
  }
  
  Future<void> _loadLoans() async {
    final prefs = await SharedPreferences.getInstance();
    final loanDataString = prefs.getString('loanData') ?? '[]';

    try {
      final List<dynamic> decodedData = jsonDecode(loanDataString);
      setState(() {
        _loanList = List<Map<String, String>>.from(
          decodedData.map((loan) => Map<String, String>.from(loan)),
        );
        _filteredLoans = _loanList; 
      });
    } catch (e) {
      print('Error loading loans: $e');
      setState(() {
        _loanList = [];
        _filteredLoans = [];
      });
    }
  }

  void _filterLoans() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _searchQuery = query;
      _filteredLoans = _loanList.where((loan) {
        final loanName = loan['fullName']?.toLowerCase() ?? '';
        return loanName.contains(_searchQuery);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Search Loan',
          style: AppTheme.headerStyle(color: whiteColor),
        ),
        iconTheme: const IconThemeData(
          color: whiteColor, 
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CustomTextField(
              _searchController,
              hint: 'Enter Creditor Name',
              password: false,
              border: Border.all(color: greyColor),
            ),
            10.height(), 
            const Text(
              'You can search for loans by typing the creditor\'s name.',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
            ),
            20.height(),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: _filteredLoans.length,
                itemBuilder: (context, index) {
                  final loan = _filteredLoans[index];
                  final loanType = LoanType.values.firstWhere(
                    (e) => e.name == loan['loanType'],
                    orElse: () => LoanType.LoanGivenByMe,
                  );
                  return LoanInfoCard(
                    loanName: loan['loanName'] ?? '',
                    fullName: loan['fullName'] ?? '',
                    loanAmount: loan['loanAmount'] ?? '',
                    incurredDate: loan['incurredDate'] ?? '',
                    isLoaned: true,
                    loanType: loanType,
                    onTap: () {
                      // Handle tap, maybe show loan details
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
