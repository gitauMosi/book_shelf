import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../bookmark/views/bookmark_screen.dart';
import '../../home/views/home_screen.dart';

final mainScreenIndexProvider = NotifierProvider<ScreenIndex, int>(
  ScreenIndex.new,
);

class ScreenIndex extends Notifier<int> {
  @override
  int build() {
    return 0;
  }

  void increment(int index) {
    state = index;
  }
}

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  final List<Widget> _pages = const [HomeScreen(), BookmarkScreen()];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: _pages[ref.watch(mainScreenIndexProvider)],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: ref.watch(mainScreenIndexProvider),
        onTap: (index) {
          ref.read(mainScreenIndexProvider.notifier).increment(index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmarks',
          ),
        ],
      ),
    );
  }
}
