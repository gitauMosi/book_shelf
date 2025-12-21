import 'package:book_shelf/data/models/book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookDetailsScreen extends ConsumerStatefulWidget {
  final Book book;
  final String? heroTag;

  const BookDetailsScreen({super.key, required this.book, this.heroTag});

  @override
  ConsumerState<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends ConsumerState<BookDetailsScreen> {
  bool _isDescriptionExpanded = false;
  bool _isFavorite = false;
  bool _isInLibrary = false;

  @override
  Widget build(BuildContext context) {
    final book = widget.book;
    final heroTag = widget.heroTag ?? '${book.id}';

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Book Cover and App Bar
          _bookCoverAndAppBar(book, heroTag, context),

          // Book Details Content
          _booksDetailsContent(context, book),
        ],
      ),
      bottomNavigationBar: _BottomActionBar(
        onReadPressed: _readBook,
        onBuyPressed: _buyBook,
      ),
    );
  }

  SliverList _booksDetailsContent(BuildContext context, Book book) {
    final bookSummary = book.summary ?? '';
    return SliverList(
      delegate: SliverChildListDelegate([
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Author
                Text(
                  book.title,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  book.authors.first.name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 16),

                // Action Buttons
                _ActionButtons(
                  isFavorite: _isFavorite,
                  isInLibrary: _isInLibrary,
                  onFavoritePressed: _toggleFavorite,
                  onAddToLibraryPressed: _toggleLibrary,
                  onReadPressed: _readBook,
                ),
                const SizedBox(height: 32),

                // Description
                if (bookSummary.isNotEmpty  == true) ...[
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _BookDescription(
                    description: bookSummary,
                    isExpanded: _isDescriptionExpanded,
                    onToggle: () => setState(() {
                      _isDescriptionExpanded = !_isDescriptionExpanded;
                    }),
                  ),
                  const SizedBox(height: 32),
                ],
              ],
            ),
          ),
        ),
      ]),
    );
  }

  SliverAppBar _bookCoverAndAppBar(
    Book book,
    String heroTag,
    BuildContext context,
  ) {
    return SliverAppBar(
      expandedHeight: 320,
      collapsedHeight: kToolbarHeight,
      pinned: true,
      floating: false,
      snap: false,
      stretch: true,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: _BookCoverImage(book: book, heroTag: heroTag),
      ),
      leading: IconButton(
        icon: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black.withOpacity(0.5),
          ),
          padding: const EdgeInsets.all(8),
          child: const Icon(Icons.arrow_back_rounded, size: 24),
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black.withOpacity(0.5),
            ),
            padding: const EdgeInsets.all(8),
            child: const Icon(Icons.share_rounded, size: 24),
          ),
          onPressed: _shareBook,
        ),
      ],
    );
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
    // TODO: Implement favorite logic with provider
  }

  void _toggleLibrary() {
    setState(() {
      _isInLibrary = !_isInLibrary;
    });
    // TODO: Implement library logic with provider
  }

  Future<void> _shareBook() async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Share functionality is not implemented yet.'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Future<void> _readBook() async {
    // TODO: Implement reading logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Opening book...'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Future<void> _buyBook() async {
    // snackbar to indicate not implemented
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Buy functionality is not implemented yet.'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

// Book Cover Image Widget
class _BookCoverImage extends StatelessWidget {
  final Book book;
  final String heroTag;

  const _BookCoverImage({required this.book, required this.heroTag});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background Gradient
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.8),
                Colors.black.withOpacity(0.3),
                Colors.transparent,
              ],
            ),
          ),
        ),

        // Book Cover Image or Placeholder
        Positioned(
          top: kToolbarHeight + 40,
          left: 0,
          right: 0,
          child: Hero(
            tag: heroTag,
            child: Container(
              width: 180,
              height: 260,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
                image: book.coverImage != null
                    ? DecorationImage(
                        image: NetworkImage(book.coverImage ?? ''),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Icon(
                    Icons.menu_book_rounded,
                    size: 64,
                    color: Theme.of(context).iconTheme.color?.withOpacity(0.4),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Action Buttons Widget
class _ActionButtons extends StatelessWidget {
  final bool isFavorite;
  final bool isInLibrary;
  final VoidCallback onFavoritePressed;
  final VoidCallback onAddToLibraryPressed;
  final VoidCallback onReadPressed;

  const _ActionButtons({
    required this.isFavorite,
    required this.isInLibrary,
    required this.onFavoritePressed,
    required this.onAddToLibraryPressed,
    required this.onReadPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: onReadPressed,
            icon: const Icon(Icons.play_arrow_rounded),
            label: const Text('Read Now'),
            style: ElevatedButton.styleFrom(
              elevation: 0.1,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
        const SizedBox(width: 12),
        IconButton.filledTonal(
          onPressed: onFavoritePressed,
          icon: Icon(
            isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
            color: isFavorite ? Theme.of(context).colorScheme.error : null,
          ),
          tooltip: isFavorite ? 'Remove from favorites' : 'Add to favorites',
        ),
        const SizedBox(width: 8),
        IconButton.filledTonal(
          onPressed: onAddToLibraryPressed,
          icon: Icon(
            isInLibrary
                ? Icons.library_add_check_rounded
                : Icons.library_add_rounded,
          ),
          tooltip: isInLibrary ? 'Remove from library' : 'Add to library',
        ),
      ],
    );
  }
}

// Book Description Widget
class _BookDescription extends StatelessWidget {
  final String description;
  final bool isExpanded;
  final VoidCallback onToggle;

  const _BookDescription({
    required this.description,
    required this.isExpanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          description,
          maxLines: isExpanded ? null : 4,
          overflow: isExpanded ? null : TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            height: 1.6,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        if (description.length > 200)
          TextButton(
            onPressed: onToggle,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(isExpanded ? 'Show less' : 'Show more'),
                Icon(
                  isExpanded
                      ? Icons.expand_less_rounded
                      : Icons.expand_more_rounded,
                  size: 20,
                ),
              ],
            ),
          ),
      ],
    );
  }
}

// Bottom Action Bar
class _BottomActionBar extends StatelessWidget {
  final VoidCallback onReadPressed;
  final VoidCallback onBuyPressed;

  const _BottomActionBar({
    required this.onReadPressed,
    required this.onBuyPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          // border: Border(
          //   top: BorderSide(
          //     color: Theme.of(context).colorScheme.outlineVariant,
          //     width: 1,
          //   ),
          // ),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: onBuyPressed,
                child: const Text('Buy Now'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FilledButton(
                onPressed: onReadPressed,
                child: const Text('Read Free'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
