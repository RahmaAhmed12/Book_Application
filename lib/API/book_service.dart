
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;  // for fetchBookByKey using http
import '../model/book_model.dart';

class BookService {
  final Dio _dio = Dio();

  // Existing method using Dio to fetch books by category
  Future<List<Book>> fetchBooksByCategory(
      String category, {
        int limit = 10,
        int offset = 0,
      }) async {
    try {
      final response = await _dio.get(
        "https://openlibrary.org/subjects/$category.json",
        queryParameters: {
          'limit': limit,
          'offset': offset,
        },
      );

      if (response.statusCode == 200) {
        final works = response.data['works'] as List;
        return works.map((work) => Book.fromJson(work)).toList();
      } else {
        throw Exception("Failed to load books");
      }
    } catch (e) {
      throw Exception("Error Fetching Book: $e");
    }
  }

}
