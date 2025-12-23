import '../entities/bookshelf_entity.dart';
import '../../data/models/bookshelf_response.dart';

abstract class BooksShelfRepository {
  Future<BookshelfResponse> fetchBooksShelves({String? nextUrl});
  Future<BookshelfResponse> getBooksShelfById({
   String? nextUrl,
    required String bookshelfId,
  });

  Future<List<Bookshelf>> fetchBooksShelvesFromDb();
  Future<void> saveBooksShelvesFromDb({required List<Bookshelf> shelfs});
}
