import 'package:go_router/go_router.dart';
import 'package:manage_loan/screens/splash_screen.dart';

final router =  GoRouter(
  initialLocation:'/',
  routes:[
    GoRoute(path: '/', builder: (context,state) => const SplashScreen(),)
  ]
);