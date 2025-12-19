import 'author.dart';

class Book {
  final int id;
  final String title;
  final String? alternativeTitle;
  final List<Author> authors;
  final List<String> subjects;
  final List<String> bookshelves;
  final Map<String, String> formats;
  final int downloadCount;
  final DateTime issued;
  final String summary;
  final String readingEaseScore;
  final String coverImage;
  final bool? removedFromCatalog;
  final bool? isFavorite;

  Book({
    required this.id,
    required this.title,
    this.alternativeTitle,
    required this.authors,
    required this.subjects,
    required this.bookshelves,
    required this.formats,
    required this.downloadCount,
    required this.issued,
    required this.summary,
    required this.readingEaseScore,
    required this.coverImage,
    this.removedFromCatalog,
    this.isFavorite = false,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      alternativeTitle: json['alternative_title'],
      authors: (json['authors'] as List<dynamic>)
          .map((e) => Author.fromJson(e))
          .toList(),
      subjects: List<String>.from(json['subjects']),
      bookshelves: List<String>.from(json['bookshelves']),
      formats: Map<String, String>.from(json['formats']),
      downloadCount: json['download_count'],
      issued: DateTime.parse(json['issued']),
      summary: json['summary'],
      readingEaseScore: json['reading_ease_score'],
      coverImage: json['cover_image'],
      removedFromCatalog: json['removed_from_catalog'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'alternative_title': alternativeTitle,
      'authors': authors.map((e) => e.toJson()).toList(),
      'subjects': subjects,
      'bookshelves': bookshelves,
      'formats': formats,
      'download_count': downloadCount,
      'issued': issued.toIso8601String(),
      'summary': summary,
      'reading_ease_score': readingEaseScore,
      'cover_image': coverImage,
      'removed_from_catalog': removedFromCatalog,
    };
  }
}
