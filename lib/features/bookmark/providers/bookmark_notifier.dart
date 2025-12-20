import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/book.dart';
import 'bookmark_state.dart';

class BookmarkNotifier extends Notifier<BookmarkState> {
  @override
  BookmarkState build() {
    return BookmarkState(bookmarkedBooks: []);
  }

  void toggleBookmark(Book book) {
    final isBookmarked = state.bookmarkedBooks.any((b) => b.id == book.id);
    if (isBookmarked) {
      removeBookmark(book);
    } else {
      addBookmark(book);
    }
  }

  void addBookmark(Book book) {
    final updatedList = [...state.bookmarkedBooks, book];
    state = state.copyWith(bookmarkedBooks: updatedList);
  }

  void removeBookmark(Book book) {
    final updatedList = state.bookmarkedBooks
        .where((b) => b.id != book.id)
        .toList();
    state = state.copyWith(bookmarkedBooks: updatedList);
  }
}
