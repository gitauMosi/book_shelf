import 'package:book_shelf/domain/entities/book_entity.dart' as domain;
import 'book.dart';

class BooksResponse {
  final String? next;
  final String? previous;
  final List<domain.Book> results;

  BooksResponse({
    required this.next,
    required this.previous,
    required this.results,
  });

  factory BooksResponse.fromJson(Map<String, dynamic> json) {
    return BooksResponse(
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List<dynamic>)
          .map((e) => domain.Book.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'next': next,
      'previous': previous,
      'results': results.map((e) => e.toJson()).toList(),
    };
  }
}
