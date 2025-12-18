

import '../../../data/models/book.dart';

class HomeState {
  HomeState({
    this.books = const [],
    this.isLoading = false,
    this.hasError = false,
    this.nextUrl,
  });

  final List<Book> books;
  final bool isLoading;
  final bool hasError;
  final String? nextUrl;

  HomeState copyWith({
    List<Book>? books,
    bool? isLoading,
    bool? hasError,
    String? nextUrl,
  }) {
    return HomeState(
      books: books ?? this.books,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      nextUrl: nextUrl ?? this.nextUrl,
    );
  }
}