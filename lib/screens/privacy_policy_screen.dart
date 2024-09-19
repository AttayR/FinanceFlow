import 'package:flutter/material.dart';
import 'package:manage_loan/config/extension.dart';
import 'package:manage_loan/styles/colors.dart';
import 'package:manage_loan/styles/theme.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Privacy Policy', style: AppTheme.headerStyle(color: whiteColor)),
        iconTheme: const IconThemeData(
          color: whiteColor, 
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Privacy Policy for FinanceFlow',
                style: AppTheme.headerStyle(),
              ),
              16.height(),
              Text(
                'Welcome to FinanceFlow! Your privacy is important to us. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our application. Please read this policy carefully. If you do not agree with the terms of this privacy policy, please do not access the application.',
                style: AppTheme.titleStyle(),
              ),
              16.height(),
              Text(
                '1. Information Collection',
                style: AppTheme.headerStyle(),
              ),
              Text(
                'We collect personal information such as your full name, contact number, loan start date, end date, and the amount of the loan. This information is collected when you register or enter loan details into the app. This data helps us manage and track your loans effectively.',
                style: AppTheme.titleStyle(),
              ),
              16.height(),
              Text(
                '2. Use of Information',
                style: AppTheme.headerStyle(),
              ),
              Text(
                'The information collected is used to manage and track your loans, including recording and displaying loan details, processing transactions, and providing you with relevant notifications and updates. This helps you keep an accurate record of your financial activities.',
                style: AppTheme.titleStyle(),
              ),
              16.height(),
              Text(
                '3. Data Security and Storage',
                style: AppTheme.headerStyle(),
              ),
              Text(
                'Your personal information is stored locally on your device and is secured using encryption and other protective measures. We implement reasonable security practices to safeguard your data from unauthorized access, disclosure, alteration, or destruction. However, no method of transmission over the internet or electronic storage is completely secure.',
                style: AppTheme.titleStyle(),
              ),
              16.height(),
              Text(
                '4. Data Retention',
                style: AppTheme.headerStyle(),
              ),
              Text(
                'Your personal information is retained for as long as necessary to fulfill the purposes outlined in this policy or as required by law. You can request to delete your data at any time by contacting us through the app or via email.',
                style: AppTheme.titleStyle(),
              ),
              16.height(),
              Text(
                '5. Third-Party Services',
                style: AppTheme.headerStyle(),
              ),
              Text(
                'We do not share your personal information with third-party services except as required to fulfill your loan management needs or as mandated by law. We may use third-party analytics services to improve the app, but these services do not have access to your personal data.',
                style: AppTheme.titleStyle(),
              ),
              16.height(),
              Text(
                '6. User Rights',
                style: AppTheme.headerStyle(),
              ),
              Text(
                'You have the right to access, correct, or delete your personal information. You can update your information through the app settings or by contacting us directly. We will respond to your requests as promptly as possible.',
                style: AppTheme.titleStyle(),
              ),
              16.height(),
              Text(
                '7. Cookies and Tracking Technologies',
                style: AppTheme.headerStyle(),
              ),
              Text(
                'We use cookies and other tracking technologies to enhance your experience with the app and to collect usage data for improving functionality. You can manage your cookie preferences through your device settings.',
                style: AppTheme.titleStyle(),
              ),
              16.height(),
              Text(
                '8. Changes to Privacy Policy',
                style: AppTheme.headerStyle(),
              ),
              Text(
                'We may update this privacy policy from time to time to reflect changes in our practices or for other operational, legal, or regulatory reasons. We will notify you of any significant changes by posting the new policy on the app. Your continued use of the app after such changes constitutes your acceptance of the updated policy.',
                style: AppTheme.titleStyle(),
              ),
              16.height(),
              Text(
                '9. Contact Us',
                style: AppTheme.headerStyle(),
              ),
              Text(
                'If you have any questions or concerns about this privacy policy or how we handle your personal information, please contact us at support@financeflow.com.',
                style: AppTheme.titleStyle(),
              ),
              16.height(),
              Text(
                '10. Legal Compliance',
                style: AppTheme.headerStyle(),
              ),
              Text(
                'We comply with applicable data protection laws and regulations. In the event of a legal obligation, we may disclose your information to comply with legal processes or enforceable government requests.',
                style: AppTheme.titleStyle(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
