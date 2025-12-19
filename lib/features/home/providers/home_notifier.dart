import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/app_providers.dart';
import '../../../domain/repositories/books_repository.dart';
import 'home_state.dart';

class HomeNotifier extends Notifier<HomeState> {
  late final BooksRepository _repository;

  @override
  HomeState build() {
    _repository = ref.read(booksRepositoryProvider);
    return HomeState();
  }

  

  /// Initial load
  Future<void> loadBooks() async {
    if (state.isLoading) return;

    state = state.copyWith(
      isLoading: true,
      hasError: false,
    );

    try {
      if(state.books.isNotEmpty){
        // already loaded
        state = state.copyWith(isLoading: false);
        return;
      }else{
        final response = await _repository.fetchBooks();

        state = state.copyWith(
          books: response.results,
          nextUrl: response.next,
          isLoading: false,
        );

      } 
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        error: e.toString(),
      );
    }
  }

  /// Pagination
  Future<void> loadMoreBooks() async {
    if (state.isLoading || state.nextUrl == null) return;

    state = state.copyWith(isLoading: true);

    try {
      final response =
          await _repository.fetchBooks(nextUrl: state.nextUrl);

      state = state.copyWith(
        books: [...state.books, ...response.results],
        nextUrl: response.next,
        isLoading: false,

      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        error: e.toString(),
      );
    }
  }
}
