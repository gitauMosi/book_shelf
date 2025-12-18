import '../../core/services/app_client.dart';
import '../../domain/repositories/books_repository.dart';
import '../models/books_response.dart';

class BooksRepositoryImpl extends BooksRepository {
  final ApiClient apiClient;

  BooksRepositoryImpl({required this.apiClient});

  @override
  Future<BooksResponse> fetchBooks({String? nextUrl}) async {
    try {
      final response = await apiClient.get(nextUrl ?? '/books');

      if (response.statusCode == 200) {
        return BooksResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load books: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
