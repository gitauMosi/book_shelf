import '../../core/services/app_client.dart';
import '../../domain/repositories/bookhelf_repository.dart';
import '../models/bookshelf_response.dart';

class BookshelfRepositoryImpl extends BooksShelfRepository {
  final ApiClient apiClient;

  BookshelfRepositoryImpl({required this.apiClient});

  @override
  Future<BookshelfResponse> fetchBooksShelves({String? nextUrl}) async {
    try {
      final response = await apiClient.get(
        path: '/bookshelves',
        nextUrl: nextUrl,
      );

      if (response.statusCode == 200) {
        return BookshelfResponse.fromJson(response.data);
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
}
