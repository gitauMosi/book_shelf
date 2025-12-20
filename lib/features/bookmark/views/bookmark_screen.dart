import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/book.dart';
import '../components/bookmarked_tile.dart';
import '../providers/bookmark_provider.dart';

class BookmarkScreen extends ConsumerWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarkedBooks = ref.watch(bookmarkProvider).bookmarkedBooks;
    return Scaffold(
      appBar: AppBar(title: const Text("Bookmarks")),
      body: bookmarkedBooks.isEmpty
          ? const _EmptyBooksMarkBody()
          : _buidBookMarkBody(books: bookmarkedBooks),
    );
  }

  Widget _buidBookMarkBody({required List<Book> books}) {
    return ListView.builder(
      itemCount: books.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return BookMarkedTile(book: books[index]);
      },
    );
  }
}

class _EmptyBooksMarkBody extends StatelessWidget {
  const _EmptyBooksMarkBody();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bookmark_border, size: 100, color: Colors.grey[400]),
          const SizedBox(height: 20),
          Text(
            'No bookmarks yet',
            style: TextStyle(fontSize: 24, color: Colors.grey[600]),
          ),
          const SizedBox(height: 10),
          Text(
            'Start adding bookmarks to see them here.',
            style: TextStyle(fontSize: 16, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }
}
