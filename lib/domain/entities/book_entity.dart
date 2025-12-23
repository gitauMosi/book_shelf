import 'package:hive/hive.dart';

import 'author_entity.dart';

part 'book_entity.g.dart';

@HiveType(typeId: 2)
class Book {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String? alternativeTitle;

  @HiveField(3)
  final List<Author> authors;

  @HiveField(4)
  final List<String> subjects;

  @HiveField(5)
  final List<String> bookshelves;

  @HiveField(6)
  final Map<String, String> formats;

  @HiveField(7)
  final int downloadCount;

  @HiveField(8)
  final DateTime? issued;

  @HiveField(9)
  final String? summary;

  @HiveField(10)
  final String? readingEaseScore;

  @HiveField(11)
  final String? coverImage;

  @HiveField(12)
  final String? mediaType;

  @HiveField(13)
  final bool? removedFromCatalog;

  @HiveField(14)
  final bool? isFavorite;

  const Book({
    required this.id,
    required this.title,
    this.alternativeTitle,
    required this.authors,
    this.subjects = const [],
    this.bookshelves = const [],
    this.formats = const {},
    required this.downloadCount,
    this.issued,
    this.summary,
    this.readingEaseScore,
    this.coverImage,
    this.mediaType,
    this.removedFromCatalog,
    this.isFavorite = false,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      alternativeTitle: json['alternative_title'],
      authors: (json['authors'] as List<dynamic>? ?? [])
          .map((e) => Author.fromJson(e))
          .toList(),
      subjects:
          (json['subjects'] as List<dynamic>?)?.cast<String>() ?? const [],
      bookshelves:
          (json['bookshelves'] as List<dynamic>?)?.cast<String>() ?? const [],
      formats:
          (json['formats'] as Map<String, dynamic>?)
                  ?.map((k, v) => MapEntry(k, v.toString())) ??
              const {},
      downloadCount: json['download_count'] ?? 0,
      issued: json['issued'] != null
          ? DateTime.tryParse(json['issued'])
          : null,
      summary: json['summary'],
      readingEaseScore: json['reading_ease_score'],
      coverImage: json['cover_image'],
      mediaType: json['media_type'],
      removedFromCatalog: json['removed_from_catalog'],
      isFavorite: json['is_favorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'alternative_title': alternativeTitle,
        'authors': authors.map((e) => e.toJson()).toList(),
        'subjects': subjects,
        'bookshelves': bookshelves,
        'formats': formats,
        'download_count': downloadCount,
        'issued': issued?.toIso8601String(),
        'summary': summary,
        'reading_ease_score': readingEaseScore,
        'cover_image': coverImage,
        'media_type': mediaType,
        'removed_from_catalog': removedFromCatalog,
        'is_favorite': isFavorite,
      };
}
