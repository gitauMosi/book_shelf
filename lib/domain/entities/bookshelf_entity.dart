import 'package:hive/hive.dart';

import 'book_entity.dart';


part 'bookshelf_entity.g.dart';

@HiveType(typeId: 3)
class Bookshelf {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String? description;

  @HiveField(3)
  final int bookCount;

  @HiveField(4)
  final int downloadCount;

  @HiveField(5)
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
      id: json['id'],
      name: json['name'],
      description: json['description'],
      bookCount: json['book_count'],
      downloadCount: json['download_count'],
      books: json['books'] != null
          ? (json['books'] as List)
              .map((e) => Book.fromJson(e))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'book_count': bookCount,
        'download_count': downloadCount,
        if (books != null)
          'books': books!.map((e) => e.toJson()).toList(),
      };
}
