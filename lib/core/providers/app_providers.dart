import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/books_repository_impl.dart';
import '../../data/repositories/bookshelf_repository_impl.dart';
import '../../data/repositories/subject_repository_impl.dart';
import '../../domain/repositories/bookhelf_repository.dart';
import '../../domain/repositories/books_repository.dart';
import '../services/app_client.dart';

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


// Repo providers
final subjectRepoImplProvider = Provider<SubjectRepositoryImpl>((ref) {
  return SubjectRepositoryImpl(apiClient: ref.watch(apiClientProvider));
});

final booksRepositoryProvider = Provider<BooksRepository>((ref) {
  return BooksRepositoryImpl(apiClient: ref.watch(apiClientProvider));
});

final bookshelfRepositoryProvider = Provider<BooksShelfRepository>((ref) {
  return BookshelfRepositoryImpl(apiClient: ref.watch(apiClientProvider));
});



