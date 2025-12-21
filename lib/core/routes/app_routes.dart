import 'package:flutter/material.dart';

import '../../data/models/book.dart';
import '../../features/bookshelf/views/bookshelf_screen.dart';
import '../../features/bookshelf/views/bookshelf_view_screen.dart';
import '../../features/home/views/books_details_screen.dart';
import '../../features/home/views/home_screen.dart';
import '../../features/main/views/main_screen.dart';
import '../../features/main/views/onboarding_screen.dart';
import '../../features/main/views/splash_screen.dart';
import '../../features/settings/settings_screen.dart';

class AppRoutes {
  AppRoutes._();
  static const String main = '/';
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String bookshelf = '/bookshelf';
  static const String settings = '/settings';
  static const String bookDetails = '/book_details';
  static const String search = '/search';
  static const String bookshelfView = '/bookshelf_view';
  static const String unknown = '/unknown';
}

Map<String, Widget Function(BuildContext)> routes = {
  AppRoutes.main: (context) => MainScreen(),
  AppRoutes.splash: (context) => SplashScreen(),
  AppRoutes.onboarding: (context) => OnboardingScreen(),
  AppRoutes.home: (context) => HomeScreen(),
  AppRoutes.bookshelf: (context) => const BookshelfScreen(),
  AppRoutes.settings: (context) => const SettingsScreen(),
  AppRoutes.bookDetails: (context) => BookDetailsScreen(
    book: ModalRoute.of(context)?.settings.arguments as Book,
  ),
  AppRoutes.bookshelfView: (context) => BookshelfViewScreen(
    bookshelfId: ModalRoute.of(context)?.settings.arguments as String,
  ),
  AppRoutes.unknown: (context) => Scaffold(
    appBar: AppBar(title: const Text('Unknown Route')),
    body: const Center(child: Text('404 - Page Not Found')),
  ),
};
