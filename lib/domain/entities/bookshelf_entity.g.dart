// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookshelf_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookshelfAdapter extends TypeAdapter<Bookshelf> {
  @override
  final int typeId = 3;

  @override
  Bookshelf read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Bookshelf(
      id: fields[0] as int,
      name: fields[1] as String,
      description: fields[2] as String?,
      bookCount: fields[3] as int,
      downloadCount: fields[4] as int,
      books: (fields[5] as List?)?.cast<Book>(),
    );
  }

  @override
  void write(BinaryWriter writer, Bookshelf obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.bookCount)
      ..writeByte(4)
      ..write(obj.downloadCount)
      ..writeByte(5)
      ..write(obj.books);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookshelfAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
