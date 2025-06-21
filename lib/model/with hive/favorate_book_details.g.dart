// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorate_book_details.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavBookDetailsAdapter extends TypeAdapter<FavBookDetails> {
  @override
  final int typeId = 1;

  @override
  FavBookDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavBookDetails(
      title: fields[0] as String,
      author: fields[1] as String,
      key: fields[12] as String,
      publishDate: fields[2] as String?,
      pagination: fields[3] as String?,
      numberOfPages: fields[4] as int?,
      isbn: fields[5] as String?,
      subjectPlaces: fields[6] as String?,
      subjects: fields[7] as String?,
      genres: fields[8] as String?,
      lcClassifications: fields[9] as String?,
      language: fields[10] as String?,
      ocaid: fields[11] as String?,
      notes: fields[13] as String?,
      imageURL: fields[14] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FavBookDetails obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.author)
      ..writeByte(2)
      ..write(obj.publishDate)
      ..writeByte(3)
      ..write(obj.pagination)
      ..writeByte(4)
      ..write(obj.numberOfPages)
      ..writeByte(5)
      ..write(obj.isbn)
      ..writeByte(6)
      ..write(obj.subjectPlaces)
      ..writeByte(7)
      ..write(obj.subjects)
      ..writeByte(8)
      ..write(obj.genres)
      ..writeByte(9)
      ..write(obj.lcClassifications)
      ..writeByte(10)
      ..write(obj.language)
      ..writeByte(11)
      ..write(obj.ocaid)
      ..writeByte(12)
      ..write(obj.key)
      ..writeByte(13)
      ..write(obj.notes)
      ..writeByte(14)
      ..write(obj.imageURL);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavBookDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
