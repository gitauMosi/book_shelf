
import '../../core/constants/db_constants.dart';
import '../../core/services/app_client.dart';
import '../../core/services/db_client.dart';
import '../../domain/entities/bookshelf_entity.dart';
import '../../domain/repositories/bookhelf_repository.dart';
import '../models/bookshelf_response.dart';

class BookshelfRepositoryImpl extends BooksShelfRepository {
  final ApiClient apiClient;
  final DbClient db;

  BookshelfRepositoryImpl({required this.apiClient, required this.db});

  @override
  Future<BookshelfResponse> fetchBooksShelves({String? nextUrl}) async {
    try {
      final response = await apiClient.get(
        path: '/bookshelves',
        nextUrl: nextUrl,
      );

      if (response.statusCode == 200) {
        final bookshelfs = BookshelfResponse.fromJson(response.data);
        return bookshelfs;
      } else {
        throw Exception('Failed to load books shelfs: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BookshelfResponse> getBooksShelfById({
    String? nextUrl,
    required String bookshelfId,
  }) async {
    try {
      final response = await apiClient.get(
        path: '/bookshelves/$bookshelfId',
        nextUrl: nextUrl,
      );

      if (response.statusCode == 200) {
        return BookshelfResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to books shelf: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Bookshelf>> fetchBooksShelvesFromDb() async {
    try {
      final dynamic data = db.get(key: DbConstantsKeys.shelfsKey);

      if (data == null) {
        return [];
      }

      if (data is List<Bookshelf>) {
        return data;
      } else if (data is List<dynamic>) {
        return data.cast<Bookshelf>();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> saveBooksShelvesFromDb({required List<Bookshelf> shelfs}) async {
    await db.add(key: DbConstantsKeys.shelfsKey, value: shelfs);
  }
}
