import '../../../data/models/book.dart';

class BookmarkState {
  final List<Book> bookmarkedBooks;
  BookmarkState({this.bookmarkedBooks = const []});

  BookmarkState copyWith({List<Book>? bookmarkedBooks}) {
    return BookmarkState(
      bookmarkedBooks: bookmarkedBooks ?? this.bookmarkedBooks,
    );
  }
}
