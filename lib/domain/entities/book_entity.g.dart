// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookAdapter extends TypeAdapter<Book> {
  @override
  final int typeId = 2;

  @override
  Book read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Book(
      id: fields[0] as int,
      title: fields[1] as String,
      alternativeTitle: fields[2] as String?,
      authors: (fields[3] as List).cast<Author>(),
      subjects: (fields[4] as List).cast<String>(),
      bookshelves: (fields[5] as List).cast<String>(),
      formats: (fields[6] as Map).cast<String, String>(),
      downloadCount: fields[7] as int,
      issued: fields[8] as DateTime?,
      summary: fields[9] as String?,
      readingEaseScore: fields[10] as String?,
      coverImage: fields[11] as String?,
      mediaType: fields[12] as String?,
      removedFromCatalog: fields[13] as bool?,
      isFavorite: fields[14] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, Book obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.alternativeTitle)
      ..writeByte(3)
      ..write(obj.authors)
      ..writeByte(4)
      ..write(obj.subjects)
      ..writeByte(5)
      ..write(obj.bookshelves)
      ..writeByte(6)
      ..write(obj.formats)
      ..writeByte(7)
      ..write(obj.downloadCount)
      ..writeByte(8)
      ..write(obj.issued)
      ..writeByte(9)
      ..write(obj.summary)
      ..writeByte(10)
      ..write(obj.readingEaseScore)
      ..writeByte(11)
      ..write(obj.coverImage)
      ..writeByte(12)
      ..write(obj.mediaType)
      ..writeByte(13)
      ..write(obj.removedFromCatalog)
      ..writeByte(14)
      ..write(obj.isFavorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
