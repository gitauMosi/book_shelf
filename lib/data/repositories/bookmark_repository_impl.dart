import '../../core/constants/db_constants.dart';
import '../../core/services/db_client.dart';
import '../../domain/entities/book_entity.dart';
import '../../domain/repositories/bookmark_repository.dart';

class BookmarkRepositoryImpl extends BookmarkRepository {
  final DbClient db;
  BookmarkRepositoryImpl({required this.db});

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
