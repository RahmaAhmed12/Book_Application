// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookDetails _$BookDetailsFromJson(Map<String, dynamic> json) => BookDetails(
      title: json['title'] as String,
      author: json['author'] as String,
      key: json['key'] as String,
      publishDate: json['publishDate'] as String?,
      pagination: json['pagination'] as String?,
      numberOfPages: (json['numberOfPages'] as num?)?.toInt(),
      isbn: json['isbn'] as String?,
      subjectPlaces: json['subjectPlaces'] as String?,
      subjects: json['subjects'] as String?,
      genres: json['genres'] as String?,
      lcClassifications: json['lcClassifications'] as String?,
      language: json['language'] as String?,
      ocaid: json['ocaid'] as String?,
      notes: json['notes'] as String?,
      imageURL: json['imageURL'] as String,
    );

Map<String, dynamic> _$BookDetailsToJson(BookDetails instance) =>
    <String, dynamic>{
      'title': instance.title,
      'author': instance.author,
      'publishDate': instance.publishDate,
      'pagination': instance.pagination,
      'numberOfPages': instance.numberOfPages,
      'isbn': instance.isbn,
      'subjectPlaces': instance.subjectPlaces,
      'subjects': instance.subjects,
      'genres': instance.genres,
      'lcClassifications': instance.lcClassifications,
      'language': instance.language,
      'ocaid': instance.ocaid,
      'key': instance.key,
      'notes': instance.notes,
      'imageURL': instance.imageURL,
    };
