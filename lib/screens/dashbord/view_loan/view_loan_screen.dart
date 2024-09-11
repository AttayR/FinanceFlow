import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:manage_loan/styles/colors.dart';
import 'package:manage_loan/styles/theme.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewLoanScreen extends StatefulWidget {
  const ViewLoanScreen({super.key});

  @override
  State<ViewLoanScreen> createState() => _ViewLoanScreenState();
}

class _ViewLoanScreenState extends State<ViewLoanScreen> {
  List<Map<String, dynamic>> loanDataList = [];

  @override
  void initState() {
    super.initState();
    _loadLoanData();
  }

  Future<void> _loadLoanData() async {
    final prefs = await SharedPreferences.getInstance();
    final loanDataString = prefs.getString('loanData') ?? '[]';

    try {
      final decodedData = jsonDecode(loanDataString);
      if (decodedData is List) {
        setState(() {
          loanDataList = List<Map<String, dynamic>>.from(decodedData);
        });
      } else {
        print('Decoded data is not a list.');
        setState(() {
          loanDataList = [];
        });
      }
    } catch (e) {
      print('Error decoding data: $e');
      setState(() {
        loanDataList = [];
      });
    }
  }

  Future<void> _generateAndPrintPdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Loan Details', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              ...loanDataList.map(
                (loan) => pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('Loan Name: ${loan['loanName'] ?? 'N/A'}'),
                    pw.Text('Full Name: ${loan['fullName'] ?? 'N/A'}'),
                    pw.Text('Amount: ${loan['loanAmount'] ?? 'N/A'}'),
                    pw.Text('Start Date: ${loan['incurredDate'] ?? 'N/A'}'),
                    pw.Text('Due Date: ${loan['dueDate'] ?? 'N/A'}'),
                    pw.Text('Phone Number: ${loan['phoneNumber'] ?? 'N/A'}'),
                    pw.SizedBox(height: 10),
                    pw.Divider(),
                    pw.SizedBox(height: 10),
                  ],
                ),
              ).toList(),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Loan Details', style: AppTheme.headerStyle()),
        backgroundColor: primaryColor,
      ),
      body: loanDataList.isNotEmpty
          ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: _generateAndPrintPdf,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0), 
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0), 
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      'Print Loan List',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: loanDataList.length,
                    itemBuilder: (context, index) {
                      final loan = loanDataList[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        elevation: 3, // Shadow effect
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0), // Rounded corners
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(16.0),
                          title: Text(
                            'Loan Name: ${loan['loanName'] ?? 'N/A'}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 8),
                              Text('Full Name: ${loan['fullName'] ?? 'N/A'}'),
                              Text('Amount: ${loan['loanAmount'] ?? 'N/A'}'),
                              Text('Start Date: ${loan['incurredDate'] ?? 'N/A'}'),
                              Text('Due Date: ${loan['dueDate'] ?? 'N/A'}'),
                              Text('Phone Number: ${loan['phoneNumber'] ?? 'N/A'}'),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
          : const Center(
              child: Text('No loan data found.'),
            ),
    );
  }
}
