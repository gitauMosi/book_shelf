



import '../../../domain/entities/book_entity.dart';

class HomeState {
  HomeState({
    this.books = const [],
    this.isLoading = false,
    this.hasError = false,
    this.error,
    this.nextUrl,
  });

  final List<Book> books;
  final bool isLoading;
  final bool hasError;
  final String? error;
  final String? nextUrl;

  bool get hasMore => nextUrl != null;

  HomeState copyWith({
    List<Book>? books,
    bool? isLoading,
    bool? hasError,
    String? error,
    String? nextUrl,
  }) {
    return HomeState(
      books: books ?? this.books,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      error: error ?? this.error,
      nextUrl: nextUrl ?? this.nextUrl,
    );
  }
}
