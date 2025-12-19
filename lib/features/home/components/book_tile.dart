import 'package:flutter/material.dart';

import '../../../data/models/book.dart';
import '../views/books_details_screen.dart';

class BookTile extends StatelessWidget {
  final Book book;

  const BookTile({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: book.id.toString(),
      child: Card(
        elevation: 0,
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 4,
          ),
          leading: _buildBookCover(),
          title: Text(
            book.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          subtitle: book.authors.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    book.authors.map((author) => author.name).join(', '),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                )
              : null,
          trailing: Icon(
            Icons.chevron_right_rounded,
            color: Theme.of(context).colorScheme.outline,
          ),
          onTap: () {
            // Navigate to book details screen
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    BookDetailsScreen(book: book, heroTag: book.id.toString()),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBookCover() {
    return Container(
      width: 60,
      //height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Image.network(
        book.coverImage,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Icon(
            Icons.menu_book_rounded,
            size: 60,
            color: Colors.grey.shade500,
          );
        },
      ),
    );
  }
}
