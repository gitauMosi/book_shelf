import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/network/network_listener.dart';
import '../../bookmark/providers/bookmark_provider.dart';
import '../components/book_tile.dart';
import '../components/featured_books_tile.dart';
import '../providers/home_provider.dart';
import '../providers/home_state.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.appName, style: AppStyles.logoTextStyle),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search
            },
          ),
        ],
      ),
      body: NetworkListener(
        child: () {
          if (state.isLoading && state.books.isEmpty) {
            return const _LoadingIndicator();
          } else if (state.hasError && state.books.isEmpty) {
            return _ErrorView(
              error: state.error ?? 'Failed to load books',
              onRetry: () => ref.read(homeProvider.notifier).loadBooks(),
            );
          } else {
            return _BookListView(state: state);
          }
        }(),
      ),
    );
  }
}

class _BookListView extends ConsumerStatefulWidget {
  final HomeState state;

  const _BookListView({required this.state});

  @override
  ConsumerState<_BookListView> createState() => __BookListViewState();
}

class __BookListViewState extends ConsumerState<_BookListView> {
  final _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialData();
    });
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _loadInitialData() {
    if (widget.state.books.isEmpty) {
      ref.read(homeProvider.notifier).loadBooks();
    }
  }

  void _onScroll() {
    if (_scrollController.hasClients && _shouldLoadMore) {
      _loadMoreBooks();
    }
  }

  bool get _shouldLoadMore {
    if (!_scrollController.hasClients) return false;
    final position = _scrollController.position;
    return position.pixels >= position.maxScrollExtent - 100 &&
        !_isLoadingMore &&
        widget.state.hasMore &&
        !widget.state.hasError;
  }

  Future<void> _loadMoreBooks() async {
    if (_isLoadingMore) return;

    setState(() => _isLoadingMore = true);
    try {
      await ref.read(homeProvider.notifier).loadMoreBooks();
    } finally {
      setState(() => _isLoadingMore = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final books = widget.state.books ?? [];

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        // Featured Books Section
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: 8,
            ),
            child: Text(
              'Featured books',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 245,
            child: books.isEmpty
                ? const Center(child: Text('No books available'))
                : ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: books.length >= 10 ? 10 : books.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final book = books.reversed.elementAt(index);
                      if (book == null) return const SizedBox.shrink();
                      return FeaturedBookTile(
                        book: book,
                        onBookmarkTap: () {
                          try {
                            ref
                                .read(bookmarkProvider.notifier)
                                .toggleBookmark(book);

                             ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Bookmark updated',
                                ),
                              ),
                            );

                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Failed to update bookmark: $e',
                                ),
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 24)),

        // Discover Books Section
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Discover Books',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                _buildBookCount(books.length),
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),

        // Main Books List
        if (books.isNotEmpty)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList.separated(
              itemCount: books.length,
              separatorBuilder: (_, __) => const SizedBox(height: 6),
              itemBuilder: (context, index) {
                final book = books[index];
                if (book == null) return const SizedBox.shrink();
                return BookTile(book: book);
              },
            ),
          )
        else
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Center(
                child: Text(
                  'No books found',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
              ),
            ),
          ),

        // Footer (Loading/Error/End indicator)
        SliverToBoxAdapter(child: _buildFooter()),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
      ],
    );
  }

  Widget _buildBookCount(int count) {
    return Text(
      '$count ${count == 1 ? 'book' : 'books'}',
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildFooter() {
    if (!widget.state.hasMore && widget.state.books.isNotEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Center(
          child: Text('No more books', style: TextStyle(color: Colors.grey)),
        ),
      );
    }

    if (widget.state.hasError && widget.state.books.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          children: [
            Text(
              'Failed to load more books',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
            const SizedBox(height: 8),
            FilledButton.tonal(
              onPressed: _loadMoreBooks,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_isLoadingMore ||
        (widget.state.isLoading && widget.state.books.isNotEmpty)) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Center(child: CircularProgressIndicator.adaptive()),
      );
    }

    return const SizedBox.shrink();
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator.adaptive(),
          SizedBox(height: 16),
          Text('Loading books...'),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const _ErrorView({required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Failed to load books',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            FilledButton(onPressed: onRetry, child: const Text('Try Again')),
          ],
        ),
      ),
    );
  }
}
