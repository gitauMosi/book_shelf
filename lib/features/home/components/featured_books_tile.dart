import 'package:flutter/material.dart';

import '../../../core/constants/app_styles.dart';
import '../../../data/models/book.dart';
import '../views/books_details_screen.dart';

class FeaturedBookTile extends StatelessWidget {
  final Book book;
  final Function() onBookmarkTap;

  const FeaturedBookTile({
    super.key,
    required this.book,
    required this.onBookmarkTap,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: book.id.toString(),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppStyles.cardBorderRadius)),
        child: SizedBox(
          width: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  _buildCardImageCover(context),
                  _buildFavouriteIconButton(context, onBookmarkTap),
                ],
              ),
              _buildBookInfo(context),
              _buildRatingRow(context),
              const SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildRatingRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 4, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Icon(
                Icons.rate_review_outlined,
                size: 10,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 4),
              Text(
                '0.0',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          Wrap(
            children: [
              Icon(
                Icons.person_outline,
                size: 10,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 4),
              Text(
                book.authors.isNotEmpty
                    ? book.authors.first.name.length > 10
                          ? '${book.authors.first.name.substring(0, 10)}...'
                          : book.authors.first.name
                    : 'Unknown',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding _buildBookInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 8, right: 8),
      child: Text(
        book.title.length > 30
            ? '${book.title.substring(0, 30)}...'
            : book.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }

  Positioned _buildFavouriteIconButton(
    BuildContext context,
    Function() onBookmarkTap,
  ) {
    return Positioned(
      top: 8,
      right: 8,
      child: GestureDetector(
        onTap: onBookmarkTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.9),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(
            Icons.bookmark_border,
            size: 16,
            color: book.isFavorite! ? Colors.amber : Colors.white,
          ),
        ),
      ),
    );
  }

  GestureDetector _buildCardImageCover(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                BookDetailsScreen(book: book, heroTag: book.id.toString()),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
        child: Container(
          height: 180,
          width: 130,
          color: Theme.of(
            context,
          ).colorScheme.onSurfaceVariant.withOpacity(0.1),
          child: Image.network(
            book.coverImage,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.menu_book_rounded,
                size: 60,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              );
            },
          ),
        ),
      ),
    );
  }
}
