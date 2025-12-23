import '../../../domain/entities/bookshelf_entity.dart';

class BookshelfState {
  final List<Bookshelf> bookshelves;
  final bool isLoading;
  final bool hasError;
  final String? error;
  final String? nextUrl;

  BookshelfState({
    this.bookshelves = const [],
    this.isLoading = false,
    this.hasError = false,
    this.error,
    this.nextUrl,
  });

  bool get hasMore => nextUrl != null;

  BookshelfState copyWith({
    List<Bookshelf>? bookshelves,
    bool? isLoading,
    bool? hasError,
    String? error,
    String? nextUrl,
  }) {
    return BookshelfState(
      bookshelves: bookshelves ?? this.bookshelves,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      error: error ?? this.error,
      nextUrl: nextUrl ?? this.nextUrl,
    );
  }
}
