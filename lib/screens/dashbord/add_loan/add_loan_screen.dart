import 'package:flutter/material.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter_text_form_field/flutter_text_form_field.dart';
import 'package:go_router/go_router.dart';
import 'package:manage_loan/enum/enums.dart';
import 'package:manage_loan/shared/widgets/custom_button.dart';
import 'package:manage_loan/shared/widgets/date_picker.dart';
import 'package:manage_loan/styles/colors.dart';
import 'package:manage_loan/styles/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class AddLoanScreen extends StatefulWidget {
  const AddLoanScreen({super.key});

  @override
  State<AddLoanScreen> createState() => _AddLoanScreenState();
}

class _AddLoanScreenState extends State<AddLoanScreen> {
  Currency? currency;
  final currentDate = DateTime.now();

  LoanType? _selectedLoanType;
  String? _selectedLoanName;
  final TextEditingController _loanNameController = TextEditingController();
  final TextEditingController _loanAmountController = TextEditingController();
  final TextEditingController _incurredDateController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  final List<String> _loanNames = [
    'Personal Loan',
    'Home Loan',
    'Auto Loan',
    'Student Loan',
    'Business Loan',
    'Payday Loan',
    'Home Equity Loan',
    'Line of Credit',
    'Consolidation Loan',
    'Secured Loan'
  ];

  @override
  void dispose() {
    _loanNameController.dispose();
    _loanAmountController.dispose();
    _incurredDateController.dispose();
    _dueDateController.dispose();
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

Future<void> _saveLoanData() async {
  final prefs = await SharedPreferences.getInstance();

  // Get the existing loans or initialize an empty list if none exists
  final existingLoansString = prefs.getString('loanData') ?? '[]';
  List<dynamic> existingLoans;

  try {
    existingLoans = jsonDecode(existingLoansString);
  } catch (e) {
    existingLoans = [];
    print('Error decoding existing loans JSON: $e');
  }

  // Create a new loan object
  final newLoan = {
    'loanName': _loanNameController.text,
    'loanAmount': _loanAmountController.text,
    'loanCurrency': currency?.code ?? '',
    'incurredDate': _incurredDateController.text,
    'dueDate': _dueDateController.text,
    'fullName': _fullNameController.text,
    'phoneNumber': _phoneNumberController.text,
    'loanType': _selectedLoanType?.name ?? '',
    'selectedLoanName': _selectedLoanName ?? '',
  };

  // Add the new loan to the list
  existingLoans.add(newLoan);

  // Save the updated list back to SharedPreferences
  await prefs.setString('loanData', jsonEncode(existingLoans));
}

  bool _isFormValid() {
    return _loanNameController.text.isNotEmpty &&
        _loanAmountController.text.isNotEmpty &&
        _incurredDateController.text.isNotEmpty &&
        _dueDateController.text.isNotEmpty &&
        _fullNameController.text.isNotEmpty &&
        _phoneNumberController.text.isNotEmpty &&
        _selectedLoanType != null &&
        _selectedLoanName != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Add Loan',
          style: AppTheme.headerStyle(color: whiteColor),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCreditorDetails(),
                const SizedBox(height: 20),
                _buildLoanNameDropdown(),
                const SizedBox(height: 20),
                _buildLoanTypeDropdown(),
                const SizedBox(height: 20),
                _buildAmountAndCurrency(),
                const SizedBox(height: 20),
                _buildDateFields(),
                const SizedBox(height: 20),
                CustomButton(
                  onPressed: () async {
                    if (_isFormValid()) {
                      await _saveLoanData();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Your request has been sent correctly.'),
                        ),
                      );
                      GoRouter.of(context).go('/view_loan'); // Navigate to ViewLoanScreen
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fill all required fields.'),
                        ),
                      );
                    }
                  },
                  text: 'Send Request',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

    Widget _buildDateFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Start Date", style: AppTheme.headerStyle()),
            Text("Due Date", style: AppTheme.headerStyle()),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                _incurredDateController,
                hint: 'Select incurred date',
                onTap: () async {
                  final date = await pickDate(
                    context,
                    firstDate: DateTime(currentDate.year - 1),
                    secondDate: currentDate,
                  );
                  if (date != null) {
                    _incurredDateController.text =
                        "${date.day}-${date.month}-${date.year}";
                  }
                },
                readOnly: true,
                keyboardType: TextInputType.none,
                password: false,
                border: Border.all(color: greyColor),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: CustomTextField(
                _dueDateController,
                hint: 'Select due date',
                onTap: () async {
                  final date = await pickDate(
                    context,
                    firstDate: DateTime(currentDate.year - 1),
                    secondDate: currentDate,
                  );
                  if (date != null) {
                    _dueDateController.text =
                        "${date.day}-${date.month}-${date.year}";
                  }
                },
                readOnly: true,
                keyboardType: TextInputType.none,
                password: false,
                border: Border.all(color: greyColor),
              ),
            ),
          ],
        ),
      ],
    );
  }
  Widget _buildCreditorDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        CustomTextField(
          _fullNameController,
          hint: 'Enter creditor full name',
          keyboardType: TextInputType.text,
          password: false,
          border: Border.all(color: greyColor),
        ),
        const SizedBox(height: 16),
        CustomTextField(
          _phoneNumberController,
          hint: 'Enter creditor phone number',
          keyboardType: TextInputType.phone,
          password: false,
          border: Border.all(color: greyColor),
        ),
      ],
    );
  }

  Widget _buildLoanNameDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Loan Name',
          style: AppTheme.headerStyle(),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedLoanName,
          onChanged: (String? newValue) {
            setState(() {
              _selectedLoanName = newValue;
              _loanNameController.text = newValue ?? '';
            });
          },
          items: _loanNames.map((loanName) {
            return DropdownMenuItem<String>(
              value: loanName,
              child: Text(loanName),
            );
          }).toList(),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Select loan name',
          ),
        ),
      ],
    );
  }

  Widget _buildLoanTypeDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Loan Type',
          style: AppTheme.headerStyle(),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<LoanType>(
          value: _selectedLoanType,
          onChanged: (LoanType? newValue) {
            setState(() {
              _selectedLoanType = newValue;
            });
          },
          items: LoanType.values.map((loanType) {
            return DropdownMenuItem<LoanType>(
              value: loanType,
              child: Text(loanType.toString().split('.').last),
            );
          }).toList(),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Select loan type',
          ),
        ),
      ],
    );
  }

  Widget _buildAmountAndCurrency() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("Loan Amount", style: AppTheme.headerStyle()),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                _loanAmountController,
                hint: 'Enter amount',
                keyboardType: TextInputType.number,
                password: false,
                border: Border.all(color: greyColor),
              ),
            ),
            const SizedBox(width: 20),
           
          ],
        ),
      ],
    );
  }
 }




