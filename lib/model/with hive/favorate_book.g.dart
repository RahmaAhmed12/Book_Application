// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorate_book.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavBookAdapter extends TypeAdapter<FavBook> {
  @override
  final int typeId = 0;

  @override
  FavBook read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavBook(
      key: fields[0] as String,
      title: fields[1] as String,
      author: fields[2] as String,
      coverEditionKey: fields[3] as String?,
      imageURL: fields[4] as String,
      editionCount: fields[5] as int,
      firstPublishYear: fields[6] as int,
      subjects: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FavBook obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.author)
      ..writeByte(3)
      ..write(obj.coverEditionKey)
      ..writeByte(4)
      ..write(obj.imageURL)
      ..writeByte(5)
      ..write(obj.editionCount)
      ..writeByte(6)
      ..write(obj.firstPublishYear)
      ..writeByte(7)
      ..write(obj.subjects);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavBookAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
