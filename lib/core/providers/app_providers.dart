import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/bookmark_repository_impl.dart';
import '../../data/repositories/books_repository_impl.dart';
import '../../data/repositories/bookshelf_repository_impl.dart';
import '../../data/repositories/settings_repository_impl.dart';
import '../../data/repositories/subject_repository_impl.dart';
import '../../domain/repositories/bookhelf_repository.dart';
import '../../domain/repositories/bookmark_repository.dart';
import '../../domain/repositories/books_repository.dart';
import '../../domain/repositories/settings_repository.dart';
import '../services/app_client.dart';
import '../services/db_client.dart';

// dio provider
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  return dio;
});

// app client provider
final apiClientProvider = Provider<ApiClient>((ref) {
  final dio = ref.watch(dioProvider);

  final baseUrl = 'https://project-gutenberg-free-books-api1.p.rapidapi.com';
  final xRapidapiKey = dotenv.env['apidapiKey'] ?? '';
  final xRapidapiHost = dotenv.env['apidapiHost'] ?? '';

  return ApiClient(
    baseUrl: baseUrl,
    xRapidapiKey: xRapidapiKey,
    xRapidapiHost: xRapidapiHost,
    dio: dio,
  );
});

// Db Provider
final dbClientProvider = Provider<DbClient>((ref) {
  final db = DbClient();
  //db.init();
  return db;
});

// Repo providers
final subjectRepoImplProvider = Provider<SubjectRepositoryImpl>((ref) {
  return SubjectRepositoryImpl(
    apiClient: ref.watch(apiClientProvider),
    dbClient: ref.watch(dbClientProvider),
  );
});

final booksRepositoryProvider = Provider<BooksRepository>((ref) {
  return BooksRepositoryImpl(
    apiClient: ref.watch(apiClientProvider),
    db: ref.watch(dbClientProvider),
  );
});

final bookshelfRepositoryProvider = Provider<BooksShelfRepository>((ref) {
  return BookshelfRepositoryImpl(
    apiClient: ref.watch(apiClientProvider),
    db: ref.watch(dbClientProvider),
  );
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  final db = ref.read(dbClientProvider);
  return SettingsRepositoryImpl(db);
});

final bookmarksRepositoryProvider = Provider<BookmarkRepository>((ref) {
  final db = ref.read(dbClientProvider);
  return BookmarkRepositoryImpl(db: db);
});
