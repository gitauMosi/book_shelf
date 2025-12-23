import '../../../domain/entities/book_entity.dart';

class BookmarkState {
  final List<Book> bookmarkedBooks;
  final bool isLoading;
  final bool hasError;
  final String? error;
  BookmarkState({
    this.bookmarkedBooks = const [],
    this.isLoading = false,
    this.hasError = false,
    this.error,
  });

  BookmarkState copyWith({
    List<Book>? bookmarkedBooks,
    bool? isLoading,
    bool? hasError,
    String? error,
  }) {
    return BookmarkState(
      bookmarkedBooks: bookmarkedBooks ?? this.bookmarkedBooks,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      error: error ?? this.error,
    );
  }
}
