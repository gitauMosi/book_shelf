import 'bookshelf.dart';

class BookshelfResponse {
  final String? next;
  final String? previous;
  final List<Bookshelf> results;

  BookshelfResponse({
    required this.next,
    required this.previous,
    required this.results,
  });

  factory BookshelfResponse.fromJson(Map<String, dynamic> json) {
    return BookshelfResponse(
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List<dynamic>)
          .map((e) => Bookshelf.fromJson(e as Map<String, dynamic>))
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
