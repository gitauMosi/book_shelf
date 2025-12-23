

import '../entities/book_entity.dart';

abstract class BookmarkRepository {
  Future<List<Book>> fetchBooksFromDb();
  Future<void> saveBooksFromDb({required List<Book> books});
}