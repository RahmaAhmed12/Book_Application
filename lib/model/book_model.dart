import 'package:json_annotation/json_annotation.dart';

part 'book_model.g.dart';

@JsonSerializable()
class Book {
  final String key;
  final String title;
  final String author;
  final String? coverEditionKey;
  final String imageURL;
  final int editionCount;
  final int firstPublishYear;
  final String subjects;

  Book({
    required this.key,
    required this.title,
    required this.author,
    required this.coverEditionKey,
    required this.imageURL,
    required this.editionCount,
    required this.firstPublishYear,
    required this.subjects,
  });

  /// Custom factory to handle complex fields manually
  factory Book.fromJson(Map<String, dynamic> json) {
    final authors = json['authors'] as List?;
    final authorName = (authors != null && authors.isNotEmpty)
        ? authors.first['name']
        : 'Unknown';

    final imageUrl = json['cover_id'] != null
        ? 'https://covers.openlibrary.org/b/id/${json['cover_id']}-M.jpg'
        : 'https://via.placeholder.com/128x193.png?text=No+Cover';

    final subjectsList = json['subject'] as List<dynamic>? ?? [];

    return Book(
      key: json['key'] ?? '',
      title: json['title'] ?? 'No Title',
      author: authorName,
      coverEditionKey: json['cover_edition_key'],
      imageURL: imageUrl,
      editionCount: json['edition_count'] ?? 0,
      firstPublishYear: json['first_publish_year'] ?? 0,
      subjects: subjectsList.map((s) => s.toString()).join(', '),
    );
  }

  Map<String, dynamic> toJson() => _$BookToJson(this);
}

