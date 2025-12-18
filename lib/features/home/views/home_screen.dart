import 'package:book_shelf/features/home/providers/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/book.dart';
import '../providers/home_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    
    Future.microtask(() {
      ref.read(homeProvider.notifier).loadBooks();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= 
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(homeProvider.notifier).loadMoreBooks();
    }
  }


  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Books")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: state.isLoading && state.books.isEmpty
            ? Center(child: CircularProgressIndicator())
            : _buildBody(state),
      ),
    );
  }


  Widget _buildBody(HomeState state) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            itemCount: state.books.length,
            itemBuilder: (context, index) {
              return BookTile(book: state.books[index]);
            },
          ),
        ),
        if (state.isLoading && state.books.isNotEmpty)
          const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          ),
        if (state.hasError)
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                ref.read(homeProvider.notifier).loadMoreBooks();
              },
              child: const Text('Retry'),
            ),
          ),
      ],
    );
  }
}

class BookTile extends StatelessWidget {
  final Book book;
  const BookTile({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(book.title), subtitle: Text("Author"));
  }
}
