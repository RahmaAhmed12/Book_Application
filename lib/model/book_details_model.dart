import 'package:json_annotation/json_annotation.dart';

// If this is inside book_details_model.dart
part 'book_details_model.g.dart';


@JsonSerializable()
class BookDetails {
  final String title;
  final String author;
  final String? publishDate;
  final String? pagination;
  final int? numberOfPages;
  final String? isbn;
  final String? subjectPlaces;
  final String? subjects;
  final String? genres;
  final String? lcClassifications;
  final String? language;
  final String? ocaid;
  final String key;
  final String? notes;
  final String imageURL;

  BookDetails({
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

  factory BookDetails.fromJson(Map<String, dynamic> json) {
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

    return BookDetails(
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

  Map<String, dynamic> toJson() => _$BookDetailsToJson(this);
}

String? _joinList(dynamic list) {
  if (list == null || list is! List) return null;
  return list.map((e) => e.toString()).join(', ');
}
