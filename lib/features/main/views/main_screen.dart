import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/routes/app_routes.dart';
import '../providers/subject_provider.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  void fetchSubjectsTest(WidgetRef ref) async {
    try {
      final resp = await ref.read(fetchSubjectsProvider.future);
      print("Response: $resp");
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => fetchSubjectsTest(ref),
              child: Text("Fetch subjects"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.home);
              },
              child: Text("Navigate to Home Screen"),
            ),
          ],
        ),
      ),
    );
  }
}
