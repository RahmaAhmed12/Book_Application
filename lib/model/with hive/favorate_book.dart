import 'package:hive/hive.dart';

part 'favorate_book.g.dart';

@HiveType(typeId: 0)
class FavBook {
  @HiveField(0)
  final String key;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String author;

  @HiveField(3)
  final String? coverEditionKey;

  @HiveField(4)
  final String imageURL;

  @HiveField(5)
  final int editionCount;

  @HiveField(6)
  final int firstPublishYear;

  @HiveField(7)
  final String subjects;

  FavBook({
    required this.key,
    required this.title,
    required this.author,
    required this.coverEditionKey,
    required this.imageURL,
    required this.editionCount,
    required this.firstPublishYear,
    required this.subjects,
  });

  factory FavBook.fromJson(Map<String, dynamic> json) {
    final authors = json['authors'] as List?;
    final authorName = (authors != null && authors.isNotEmpty)
        ? authors.first['name']
        : 'Unknown';

    final imageUrl = json['cover_id'] != null
        ? 'https://covers.openlibrary.org/b/id/${json['cover_id']}-M.jpg'
        : 'https://via.placeholder.com/128x193.png?text=No+Cover';

    final subjectsList = json['subject'] as List<dynamic>? ?? [];

    return FavBook(
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
}
