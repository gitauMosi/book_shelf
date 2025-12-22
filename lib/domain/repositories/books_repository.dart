
import '../../data/models/books_response.dart';

abstract class BooksRepository {
  Future<BooksResponse> fetchBooks({String? nextUrl});
  //Future<List
}
