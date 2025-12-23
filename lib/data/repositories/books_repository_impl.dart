
import '../../core/constants/db_constants.dart';
import '../../core/services/app_client.dart';
import '../../core/services/db_client.dart';
import '../../domain/entities/book_entity.dart';
import '../../domain/repositories/books_repository.dart';
import '../models/books_response.dart';

class BooksRepositoryImpl extends BooksRepository {
  final ApiClient apiClient;
  final DbClient db;

  BooksRepositoryImpl({required this.apiClient, required this.db});

  @override
  Future<BooksResponse> fetchBooks({String? nextUrl}) async {
    try {
      final response = await apiClient.get(path: '/books', nextUrl: nextUrl);

      if (response.statusCode == 200) {
        final booksResponse = BooksResponse.fromJson(response.data);
        
        return BooksResponse(
          next: booksResponse.next,
          previous: booksResponse.previous,
          results: booksResponse.results,
        );
      } else {
        throw Exception('Failed to load books: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Book>> fetchBooksFromDb() async {
    try {
      final dynamic data = db.get(key: DbConstantsKeys.booksKey);

      if (data == null) {
        return [];
      }

      if (data is List<Book>) {
        return data;
      } else if (data is List<dynamic>) {
        return data.cast<Book>();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> saveBooksFromDb({required List<Book> books}) async {
    await db.add(key: DbConstantsKeys.booksKey, value: books);
  }
}
