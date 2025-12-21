import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/download_count_utils.dart';
import '../../../data/models/bookshelf.dart';
import '../providers/bookshelf_provider.dart';

class BookshelfViewScreen extends ConsumerWidget {
  final String bookshelfId;
  const BookshelfViewScreen({super.key, required this.bookshelfId});

  String removeCategoryPrefix(String name) {
    const prefix = 'Category:';
    if (name.startsWith(prefix)) {
      return name.substring(prefix.length).trim();
    }
    return name;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookshelfAsyncValue = ref.watch(
      fetchBookshelfByIdProvider(bookshelfId),
    );
    return Scaffold(
      appBar: AppBar(title: const Text('Bookshelf')),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: bookshelfAsyncValue.when(
          data: (bookshelf) {
            return buildContent(context, bookshelf);
          },
          error: (error, stackTrace) {
            return buildError(error.toString());
          },
          loading: () {
            return buildLoading();
          },
        ),
      ),
    );
  }

  Widget buildContent(BuildContext context, Bookshelf bookshelf) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              removeCategoryPrefix(bookshelf.name),
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${bookshelf.bookCount} books',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.download_outlined, size: 14),
                    const SizedBox(width: 4),
                    Text(getBookDownloadCountText(bookshelf.downloadCount)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),

            SizedBox(
              child: bookshelf.books != null
                  ? ListView.builder(
                      itemCount: bookshelf.books!.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Container(
                            width: 40,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(child: Icon(Icons.book, size: 24)),
                          ),
                          title: Text(bookshelf.books![index].title),
                          subtitle: Text(
                            bookshelf.books![index].authors.isNotEmpty
                                ? bookshelf.books![index].authors.first.name
                                : 'Unknown Author',
                          ),
                        );
                      },
                    )
                  : Center(child: Text('No books found')),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildError(String message) {
    return Center(child: Text(message));
  }

  Widget buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }
}
