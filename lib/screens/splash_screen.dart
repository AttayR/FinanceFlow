// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:go_router/go_router.dart';
// import 'package:manage_loan/config/constant.dart';
// import 'package:manage_loan/styles/theme.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _navigate();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset('assets/images/logo.png', width: 120, height: 120), // Updated to use image
//             Text(appName, style: AppTheme.headerStyle()),
//             Text("Better way to keep track of your loans", style: AppTheme.titleStyle()),
//           ],
//         ),
//       ),
//     );
//   }

//   void _navigate() async {
//     // Delay to simulate splash screen
//     await Future.delayed(const Duration(seconds: 3));
    
//     // Check if the user's name is stored in SharedPreferences
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool isNameSaved = prefs.containsKey('userName');

//     // Navigate based on the presence of the name
//     if (mounted) {
//       if (isNameSaved) {
//         GoRouter.of(context).go('/loan_dashbord'); // If name is stored, go to Loan Dashboard
//       } else {
//         GoRouter.of(context).go('/name_input');    // If name is not stored, go to Name Input Screen
//       }
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import 'package:manage_loan/config/constant.dart';
import 'package:manage_loan/styles/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();
    _navigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 66, 245, 233), // Light Blue
              Color.fromARGB(255, 180, 181, 182), // Dark Blue
            ],
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _animation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png', width: 150, height: 150),
                const SizedBox(height: 24),
                Text(
                  appName,
                  style: AppTheme.headerStyle(color: Colors.black),
                ),
                const SizedBox(height: 12),
                Text(
                  "Your loans, organized and simplified",
                  style: AppTheme.titleStyle(color: Colors.white.withOpacity(0.8)),
                ),
                const SizedBox(height: 40),
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigate() async {
    // Delay to simulate splash screen
    await Future.delayed(const Duration(seconds: 3));

    // Check if the user's name is stored in SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isNameSaved = prefs.containsKey('userName');

    // Navigate based on the presence of the name
    if (mounted) {
      if (isNameSaved) {
        GoRouter.of(context).go('/loan_dashbord'); // If name is stored, go to Loan Dashboard
      } else {
        GoRouter.of(context).go('/name_input');    // If name is not stored, go to Name Input Screen
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
