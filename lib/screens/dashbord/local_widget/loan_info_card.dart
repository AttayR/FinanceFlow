import 'package:flutter/material.dart';
import 'package:manage_loan/enum/enums.dart';
import 'package:manage_loan/styles/colors.dart';
import 'package:manage_loan/styles/theme.dart';

class LoanInfoCard extends StatelessWidget {
  final String loanName;
  final String loanAmount;
  final String fullName;
  final String incurredDate;
  final bool isLoaned;
  final LoanType loanType; 
  final VoidCallback onTap;

  const LoanInfoCard({
    super.key,
    required this.loanName,
    required this.fullName,
    required this.loanAmount,
    required this.incurredDate,
    required this.isLoaned,
    required this.loanType, 
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 260, // Increased width for better readability
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [primaryColor, Colors.white24.withOpacity(0.1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  isLoaned ? Icons.arrow_upward : Icons.arrow_downward,
                  color: isLoaned ? redColor : greenColor,
                  size: 24,
                ),
                Text(
                  '\$$loanAmount',
                  style: AppTheme.subTitleStyle(
                    color: blackColor,
                 
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              loanName,
              style: AppTheme.titleStyle(
                color: blackColor,
                
              ),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              loanType == LoanType.LoanGivenByMe ? 'Loaned to' : 'Borrowed from',
              style: AppTheme.subTitleStyle(
                color: Colors.red,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              fullName,
              style: AppTheme.subTitleStyle(
                color: blackColor,
                
              ),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              'Date:',
              style: AppTheme.subTitleStyle(
                color: Colors.blueGrey,
              ),
            ),
            Text(
              incurredDate,
              style: AppTheme.subTitleStyle(
                color: blackColor,
                
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
