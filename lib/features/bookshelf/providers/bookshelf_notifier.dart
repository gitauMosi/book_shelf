import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/providers/network_providers.dart';
import '../../../core/providers/app_providers.dart';
import '../../../domain/repositories/bookhelf_repository.dart';
import 'bookshelf_state.dart';

class BookshelfNotifier extends Notifier<BookshelfState> {
  late final BooksShelfRepository _repository;
  @override
  BookshelfState build() {
    _repository = ref.read(bookshelfRepositoryProvider);
    return BookshelfState();
  }

  // Initial load
  Future<void> loadBookshelves() async {
    try {
      if (state.bookshelves.isNotEmpty) {
        state = state.copyWith(isLoading: false);
        return;
      }

      state = state.copyWith(isLoading: true, hasError: false);

      // Check network connectivity
      final networkService = ref.read(networkServiceProvider);
      final isConnected = await networkService.isConnectedToInternet();

      if (isConnected) {
        try {
          final response = await _repository.fetchBooksShelves();
          await _repository.saveBooksShelvesFromDb(shelfs: response.results);

          state = state.copyWith(
            bookshelves: response.results,
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
      final bookshelves = await _repository.fetchBooksShelvesFromDb();
      state = state.copyWith(
        bookshelves: bookshelves,
        isLoading: false,
        hasError: false,
      );
    } catch (e) {
      state = state.copyWith(
        bookshelves: [],
        isLoading: false,
        hasError: false,
      );
    }
  }

  // Pagination
  Future<void> loadMoreBookshelves() async {
    if (state.isLoading || state.nextUrl == null) return;

    state = state.copyWith(isLoading: true);

    try {
      final response = await _repository.fetchBooksShelves(
        nextUrl: state.nextUrl,
      );
      final updatedBookshelves = [...state.bookshelves, ...response.results];
      state = state.copyWith(
        bookshelves: updatedBookshelves,
        nextUrl: response.next,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }
}
