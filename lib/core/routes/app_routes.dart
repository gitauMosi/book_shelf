

import 'package:book_shelf/features/home/views/home_screen.dart';
import 'package:flutter/material.dart';

import '../../features/main/views/main_screen.dart';
import '../../features/main/views/onboarding_screen.dart';
import '../../features/main/views/splash_screen.dart';

class AppRoutes {
  AppRoutes._();
  static const String main = '/';
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String settings = '/settings';
  static const String profile = '/profile';
  
}

Map<String, Widget Function(BuildContext)> routes = {
  AppRoutes.main: (context) => MainScreen(),
  AppRoutes.splash: (context) => SplashScreen(),
  AppRoutes.onboarding: (context) => OnboardingScreen(),
  AppRoutes.home: (context) => HomeScreen(),
  AppRoutes.settings: (context) => const Scaffold(body: Center(child: Text('Settings Page'))),
  AppRoutes.profile: (context) => const Scaffold(body: Center(child: Text('Profile Page'))),
};