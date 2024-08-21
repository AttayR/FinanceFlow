import 'package:go_router/go_router.dart';
import 'package:manage_loan/config/bottomTab.dart';
import 'package:manage_loan/screens/dashbord/add_loan/add_loan_screen.dart';
import 'package:manage_loan/screens/dashbord/loan_dashbord.dart';
import 'package:manage_loan/screens/dashbord/search_loan/search_loan_screen.dart';
import 'package:manage_loan/screens/dashbord/view_loan/view_loan_screen.dart';
import 'package:manage_loan/screens/privacy_policy_screen.dart';
import 'package:manage_loan/screens/splash_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(path: '/search_loan', builder: (context,state) => const SearchLoanScreen(),),
 GoRoute(
      path: '/privacy_policy',
      builder: (context, state) => const PrivacyPolicyScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) => BottomTabNavigator(child: child),
      routes: [
        GoRoute(
          path: '/loan_dashbord',
          builder: (context, state) => const LoanDashbord(),
        ),
        GoRoute(
          path: '/add_loan',
          builder: (context, state) => const AddLoanScreen(),
        ),
        GoRoute(
          path: '/view_loan',
          builder: (context, state) => const ViewLoanScreen(),
        ),
      ],
    ),
  ],
);
