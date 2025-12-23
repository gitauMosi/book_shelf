import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/app_providers.dart';
import '../../../domain/entities/book_entity.dart';
import '../../../domain/repositories/bookmark_repository.dart';
import 'bookmark_state.dart';

class BookmarkNotifier extends Notifier<BookmarkState> {
  late final BookmarkRepository _repository;
  @override
  BookmarkState build() {
    _repository = ref.read(bookmarksRepositoryProvider);
    _loadFromDb();
    return BookmarkState();
  }

  Future<void> _loadFromDb() async {
    try {
      final books = await _repository.fetchBooksFromDb();
      state.copyWith(bookmarkedBooks: books, isLoading: false, hasError: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        error: e.toString(),
      );
    }
  }

  Future<void> bookMark(List<Book> books) async {
    try {
      await _repository.saveBooksFromDb(books: books);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        error: e.toString(),
      );
    }
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
    bookMark(updatedList);
    state = state.copyWith(bookmarkedBooks: updatedList);
  }

  void removeBookmark(Book book) {
    final updatedList = state.bookmarkedBooks
        .where((b) => b.id != book.id)
        .toList();
    bookMark(updatedList);
    state = state.copyWith(bookmarkedBooks: updatedList);
  }
}
