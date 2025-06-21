import 'package:hive/hive.dart';

part 'favorate_book_details.g.dart';

@HiveType(typeId: 1)
class FavBookDetails {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String author;

  @HiveField(2)
  final String? publishDate;

  @HiveField(3)
  final String? pagination;

  @HiveField(4)
  final int? numberOfPages;

  @HiveField(5)
  final String? isbn;

  @HiveField(6)
  final String? subjectPlaces;

  @HiveField(7)
  final String? subjects;

  @HiveField(8)
  final String? genres;

  @HiveField(9)
  final String? lcClassifications;

  @HiveField(10)
  final String? language;

  @HiveField(11)
  final String? ocaid;

  @HiveField(12)
  final String key;

  @HiveField(13)
  final String? notes;

  @HiveField(14)
  final String imageURL;

  FavBookDetails({
    required this.title,
    required this.author,
    required this.key,
    this.publishDate,
    this.pagination,
    this.numberOfPages,
    this.isbn,
    this.subjectPlaces,
    this.subjects,
    this.genres,
    this.lcClassifications,
    this.language,
    this.ocaid,
    this.notes,
    required this.imageURL,
  });

  factory FavBookDetails.fromJson(Map<String, dynamic> json) {
    final authors = json['authors'] as List?;
    final authorKey = (authors != null && authors.isNotEmpty)
        ? authors.first['key'] ?? 'Unknown'
        : 'Unknown';

    final languageList = json['languages'] as List?;
    final langKey = (languageList != null && languageList.isNotEmpty)
        ? languageList.first['key']
        : null;

    final covers = json['covers'] as List?;
    final imageUrl = (covers != null && covers.isNotEmpty)
        ? 'https://covers.openlibrary.org/b/id/${covers.first}-L.jpg'
        : 'https://via.placeholder.com/150x200.png?text=No+Cover';

    final identifiers = json['identifiers'] as Map<String, dynamic>?;
    final isbn10 = identifiers?['isbn_10'] as List?;
    final isbnStr = (isbn10 != null && isbn10.isNotEmpty)
        ? isbn10.first.toString()
        : null;

    return FavBookDetails(
      title: json['title'] ?? 'No Title',
      author: authorKey,
      key: json['key'] ?? '',
      publishDate: json['publish_date'],
      pagination: json['pagination'],
      numberOfPages: json['number_of_pages'],
      isbn: isbnStr,
      subjectPlaces: _joinList(json['subject_place']),
      subjects: _joinList(json['subjects']),
      genres: _joinList(json['genres']),
      lcClassifications: _joinList(json['lc_classifications']),
      language: langKey,
      ocaid: json['ocaid'],
      notes: (json['notes'] is Map) ? json['notes']['value'] : json['notes'],
      imageURL: imageUrl,
    );
  }
}

String? _joinList(dynamic list) {
  if (list == null || list is! List) return null;
  return list.map((e) => e.toString()).join(', ');
}
