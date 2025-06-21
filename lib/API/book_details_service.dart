import 'package:dio/dio.dart';

import '../model/book_details_model.dart';


class BookDetailsService {
  final Dio _dio = Dio();

  Future<BookDetails> fetchBookDetails(String bookId) async {
    final url = "https://openlibrary.org/books/$bookId.json";

    try {
      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        return BookDetails.fromJson(response.data);
      } else {
        throw Exception("Failed to fetch book details");
      }
    } catch (e) {
      throw Exception("Error fetching book details: $e");
    }
  }
}
