import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../bookmark/views/bookmark_screen.dart';
import '../../bookshelf/bookshelf_screen.dart';
import '../../home/views/home_screen.dart';
import '../../settings/settings_screen.dart';

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

  final List<Widget> _pages = const [
    HomeScreen(),
    BookshelfScreen(),
    BookmarkScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: _pages[ref.watch(mainScreenIndexProvider)],
      bottomNavigationBar: NavigationBar(
        selectedIndex: ref.watch(mainScreenIndexProvider),
        onDestinationSelected: (index) {
          ref.read(mainScreenIndexProvider.notifier).increment(index);
        },
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.library_books),
            icon: Badge(label: Text("2"), child: Icon(Icons.library_books_outlined)),
            label: 'Bookshelf',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bookmark_rounded),
            icon: Icon(Icons.bookmark_outline_rounded),
            label: 'Bookmark',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
