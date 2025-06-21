// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) => Book(
      key: json['key'] as String,
      title: json['title'] as String,
      author: json['author'] as String,
      coverEditionKey: json['coverEditionKey'] as String?,
      imageURL: json['imageURL'] as String,
      editionCount: (json['editionCount'] as num).toInt(),
      firstPublishYear: (json['firstPublishYear'] as num).toInt(),
      subjects: json['subjects'] as String,
    );

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'key': instance.key,
      'title': instance.title,
      'author': instance.author,
      'coverEditionKey': instance.coverEditionKey,
      'imageURL': instance.imageURL,
      'editionCount': instance.editionCount,
      'firstPublishYear': instance.firstPublishYear,
      'subjects': instance.subjects,
    };
