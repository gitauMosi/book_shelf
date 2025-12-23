import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/providers/network_providers.dart';
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
    try {
      if (state.books.isNotEmpty) {
        state = state.copyWith(isLoading: false);
        return;
      }

      state = state.copyWith(isLoading: true, hasError: false);

      final networkService = ref.read(networkServiceProvider);
      final isConnected = await networkService.isConnectedToInternet();

      if (isConnected) {
        try {
          final response = await _repository.fetchBooks();
          await _repository.saveBooksFromDb(books: response.results);

          state = state.copyWith(
            books: response.results,
            nextUrl: response.next,
            isLoading: false,
            hasError: false,
          );
        } catch (e) {
          await _loadFromLocalDb();
        }
      } else {
        await _loadFromLocalDb();
      }
    } catch (e) {
      await _loadFromLocalDb();
    }
  }

  Future<void> _loadFromLocalDb() async {
    try {
      final books = await _repository.fetchBooksFromDb();
      state = state.copyWith(books: books, isLoading: false, hasError: false);
    } catch (e) {
      state = state.copyWith(books: [], isLoading: false, hasError: false);
    }
  }

  /// Pagination
  Future<void> loadMoreBooks() async {
    if (state.isLoading || state.nextUrl == null) return;

    state = state.copyWith(isLoading: true);

    try {
      final response = await _repository.fetchBooks(nextUrl: state.nextUrl);

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
