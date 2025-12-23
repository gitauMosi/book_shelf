import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/routes/app_routes.dart';
import '../../settings/providers/settings_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool _hasNavigated = false;
  Timer? _timeoutTimer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _navigateIfReady();
  }

  @override
  void dispose() {
    _timeoutTimer?.cancel();
    super.dispose();
  }

  void _navigateIfReady() {
    if (_hasNavigated) return;
    
    final settingsState = ref.read(settingsProvider);
    
    // Check if settings have finished loading
    if (settingsState.isLoading) {
      // Set a timeout to prevent infinite loading
      _timeoutTimer = Timer(const Duration(seconds: 5), () {
        if (mounted && !_hasNavigated) {
          _navigateWithTimeout();
        }
      });
      return;
    }
    
    // Settings loaded, navigate immediately
    _performNavigation(settingsState);
  }

  void _navigateWithTimeout() {
    final settingsState = ref.read(settingsProvider);
    _performNavigation(settingsState, isTimeout: true);
  }

  void _performNavigation(dynamic settingsState, {bool isTimeout = false}) {
    if (_hasNavigated) return;
    
    _hasNavigated = true;
    _timeoutTimer?.cancel();

    // Add a small delay for better UX
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        try {
          if (settingsState.isNewUser) {
            Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
            ref.read(settingsProvider.notifier).registerUser();
          } else {
            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.main, (_)=>false);
          }
        } catch (e) {
          // Handle navigation errors
          _showErrorDialog('Navigation Error: $e');
        }
      }
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final settingsState = ref.watch(settingsProvider);
    
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.book,
              size: 100,
              color: Theme.of(context).colorScheme.primary,
            ),
            Text(
              AppStrings.appName,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 20),
            if (settingsState.isLoading)
              Column(
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 10),
                  Text(
                    'Loading...',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            if (settingsState.hasError)
              Column(
                children: [
                  Icon(
                    Icons.error,
                    size: 50,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Error: ${settingsState.error}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Force reload settings
                      ref.refresh(settingsProvider);
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
