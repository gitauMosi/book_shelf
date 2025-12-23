import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/app_providers.dart';
import '../../../domain/entities/bookshelf_entity.dart';
import 'bookshelf_notifier.dart';
import 'bookshelf_state.dart';

final bookshelfProvider = NotifierProvider<BookshelfNotifier, BookshelfState>(
  BookshelfNotifier.new,
);

final fetchBookshelfByIdProvider =
    FutureProvider.family<Bookshelf, String>((ref, bookshelfId) async {
      final repository = ref.read(bookshelfRepositoryProvider);
      final response = await repository.getBooksShelfById(
        bookshelfId: bookshelfId,
      );
      return response.results.first;
    });
