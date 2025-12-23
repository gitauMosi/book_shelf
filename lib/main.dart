import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/constants/app_strings.dart';
import 'core/routes/app_routes.dart';
import 'core/services/db_client.dart';
import 'core/theme/theme.dart';
import 'domain/entities/author_entity.dart';
import 'domain/entities/book_entity.dart';
import 'domain/entities/bookshelf_entity.dart';
import 'features/settings/providers/settings_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  final db = DbClient();
  db.registerAdapter<Book>(BookAdapter());
  db.registerAdapter<Bookshelf>(BookshelfAdapter());
  db.registerAdapter<Author>(AuthorAdapter());

  await db.init();

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    return MaterialApp(
      title: AppStrings.appName,
      themeMode: settings.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: appThemeLight,
      darkTheme: appThemeDark,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      routes: routes,
    );
  }
}
