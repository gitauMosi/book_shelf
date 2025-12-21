import '../../data/models/bookshelf_response.dart';

abstract class BooksShelfRepository {
  Future<BookshelfResponse> fetchBooksShelves({String? nextUrl});
  Future<BookshelfResponse> getBooksShelfById({
   String? nextUrl,
    required String bookshelfId,
  });
}
