import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:manage_loan/styles/colors.dart';
import 'package:manage_loan/styles/theme.dart';

class EditFinancialSummaryScreen extends StatefulWidget {
  const EditFinancialSummaryScreen({super.key});

  @override
  _EditFinancialSummaryScreenState createState() =>
      _EditFinancialSummaryScreenState();
}

class _EditFinancialSummaryScreenState
    extends State<EditFinancialSummaryScreen> {
  final _loansGivenController = TextEditingController();
  final _loansReceivedController = TextEditingController();
  final _netBalanceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadFinancialSummary(); // Load saved financial data on init
  }

  // Fetch saved financial summary from SharedPreferences
  Future<void> _loadFinancialSummary() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // Fetch or set default empty values
      _loansGivenController.text = prefs.getString('loansGiven') ?? '';
      _loansReceivedController.text = prefs.getString('loansReceived') ?? '';
      _netBalanceController.text = prefs.getString('netBalance') ?? '';
    });
  }

  // Save financial summary to SharedPreferences
  Future<void> _saveFinancialSummary() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('loansGiven', _loansGivenController.text);
    await prefs.setString('loansReceived', _loansReceivedController.text);
    await prefs.setString('netBalance', _netBalanceController.text);
    Navigator.pop(context); // Navigate back after saving
  }

  @override
  void dispose() {
    _loansGivenController.dispose();
    _loansReceivedController.dispose();
    _netBalanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Edit Financial Summary",
            style: TextStyle(color: whiteColor)),
        actions: [
          IconButton(
            icon: const Icon(Icons.save, color: whiteColor),
            onPressed: _saveFinancialSummary, // Save button in app bar
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center( // Center the column
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Header explaining the purpose of the screen
                Text(
                  'Please enter your financial details below to keep track of your loans and balance:',
                  style: AppTheme.subTitleStyle(color: blackColor),
                  textAlign: TextAlign.center, // Center-align the text
                ),
                const SizedBox(height: 20),
                
                // Explain the Loans Given Out field
                Text(
                  'Loans Given Out:',
                  style: AppTheme.subTitleStyle(color: blackColor),
                  textAlign: TextAlign.start,
                ),
                Text(
                  'Enter the total amount you have lent out to others. This will help you track outstanding loans.',
                  style: TextStyle(color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _loansGivenController,
                  label: 'Loans Given Out',
                ),
                const SizedBox(height: 16),
                
                // Explain the Loans Received field
                Text(
                  'Loans Received:',
                  style: AppTheme.subTitleStyle(color: blackColor),
                ),
                Text(
                  'Enter the total amount you have borrowed from others. This will help you track what you owe.',
                  style: TextStyle(color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _loansReceivedController,
                  label: 'Loans Received',
                ),
                const SizedBox(height: 16),

                // Explain the Net Balance field
                Text(
                  'Net Balance:',
                  style: AppTheme.subTitleStyle(color: blackColor),
                ),
                Text(
                  'This is the difference between the amount you’ve lent and borrowed. It will be automatically calculated based on your inputs.',
                  style: TextStyle(color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _netBalanceController,
                  label: 'Net Balance',
                ),
                const SizedBox(height: 24),
                
                // Save button in the center
                ElevatedButton(
                  onPressed: _saveFinancialSummary, // Save data on press
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(0, 150, 136, 1.0),
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: const Text(
                    "Save",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),

                // Additional reminder
                Text(
                  'Remember to save your changes before leaving this screen.',
                  style: TextStyle(color: Colors.redAccent, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper function to build input fields
  Widget _buildTextField({
    required TextEditingController controller, 
    required String label
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label, // Field label
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: primaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: primaryColor, width: 2),
          ),
        ),
        keyboardType: TextInputType.number, // Numeric input
      ),
    );
  }
}
