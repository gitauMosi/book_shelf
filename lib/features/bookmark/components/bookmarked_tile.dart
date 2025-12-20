import 'package:flutter/material.dart';

import '../../../core/constants/app_styles.dart';
import '../../../data/models/book.dart';
import '../../home/views/books_details_screen.dart';

class BookMarkedTile extends StatelessWidget {
  final Book book;
  const BookMarkedTile({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: book.id.toString(),
      child: Card(
        elevation: 0,
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppStyles.cardBorderRadius),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          leading: Container(
            width: 50,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(book.coverImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
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
            Icons.favorite_outline,
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
}
