import 'book.dart';

class Bookshelf {
  final int id;
  final String name;
  final String? description;
  final int bookCount;
  final int downloadCount;
  final List<Book>? books;

  Bookshelf({
    required this.id,
    required this.name,
    this.description,
    required this.bookCount,
    required this.downloadCount,
    this.books,
  });

  factory Bookshelf.fromJson(Map<String, dynamic> json) {
    return Bookshelf(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      bookCount: json['book_count'] as int,
      downloadCount: json['download_count'] as int,
      books: json['books'] != null
          ? (json['books'] as List<dynamic>)
              .map((e) => Book.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'book_count': bookCount,
      'download_count': downloadCount,
      if (books != null) 'books': books!.map((e) => e.toJson()).toList(),
    };
  }
}
