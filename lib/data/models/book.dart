// import 'author.dart';

// class Book {
//   final int id;
//   final String title;
//   final String? alternativeTitle;

//   final List<Author> authors;

//   final List<String> subjects;
//   final List<String> bookshelves;
//   final Map<String, String> formats;

//   final int downloadCount;
//   final DateTime? issued;

//   final String? summary;
//   final String? readingEaseScore;
//   final String? coverImage;

//   final String? mediaType;

//   final bool? removedFromCatalog;
//   final bool? isFavorite;

//   const Book({
//     required this.id,
//     required this.title,
//     this.alternativeTitle,
//     required this.authors,
//     this.subjects = const [],
//     this.bookshelves = const [],
//     this.formats = const {},
//     required this.downloadCount,
//     this.issued,
//     this.summary,
//     this.readingEaseScore,
//     this.coverImage,
//     this.mediaType,
//     this.removedFromCatalog,
//     this.isFavorite = false,
//   });

//   factory Book.fromJson(Map<String, dynamic> json) {
//     return Book(
//       id: json['id'] as int,
//       title: json['title'] as String,
//       alternativeTitle: json['alternative_title'] as String?,

//       authors: (json['authors'] as List<dynamic>? ?? [])
//           .map((e) => Author.fromJson(e as Map<String, dynamic>))
//           .toList(),

//       subjects:
//           (json['subjects'] as List<dynamic>?)
//               ?.map((e) => e.toString())
//               .toList() ??
//           const [],

//       bookshelves:
//           (json['bookshelves'] as List<dynamic>?)
//               ?.map((e) => e.toString())
//               .toList() ??
//           const [],

//       formats:
//           (json['formats'] as Map<String, dynamic>?)?.map(
//             (k, v) => MapEntry(k, v.toString()),
//           ) ??
//           const {},

//       downloadCount: json['download_count'] as int? ?? 0,

//       issued: json['issued'] != null ? DateTime.tryParse(json['issued']) : null,

//       summary: json['summary'] as String?,
//       readingEaseScore: json['reading_ease_score'] as String?,
//       coverImage: json['cover_image'] as String?,

//       mediaType: json['media_type'] as String?,

//       removedFromCatalog: json['removed_from_catalog'] as bool?,
//       isFavorite: json['is_favorite'] as bool? ?? false,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'title': title,
//       'alternative_title': alternativeTitle,
//       'authors': authors.map((e) => e.toJson()).toList(),
//       'subjects': subjects,
//       'bookshelves': bookshelves,
//       'formats': formats,
//       'download_count': downloadCount,
//       'issued': issued?.toIso8601String(),
//       'summary': summary,
//       'reading_ease_score': readingEaseScore,
//       'cover_image': coverImage,
//       'media_type': mediaType,
//       'removed_from_catalog': removedFromCatalog,
//       'is_favorite': isFavorite,
//     };
//   }
// }
