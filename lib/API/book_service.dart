// //
// //
// // import 'package:dio/dio.dart';
// //
// // class BookService {
// //   final Dio _dio = Dio();
// //
// //   Future<List<Map<String, dynamic>>> fetchBooksByCategory(
// //       String category, {
// //         int limit = 10,
// //         int offset = 0,
// //       }) async {
// //     try {
// //       final response = await _dio.get(
// //         "https://openlibrary.org/subjects/$category.json",
// //         queryParameters: {
// //           'limit': limit,
// //           'offset': offset,
// //         },
// //       );
// //
// //       if (response.statusCode == 200) {
// //         final works = response.data['works'] as List;
// //         final List<Map<String, dynamic>> books = [];
// //
// //         for (var work in works) {
// //           books.add({
// //             "key": work['key'] ?? '',
// //             "title": work['title'] ?? 'No Title',
// //             "author": (work['authors'] as List?)?.first?['name'] ?? 'Unknown',
// //             "coverEditionKey": work['cover_edition_key'],
// //             "imageURL": work['cover_id'] != null
// //                 ? 'https://covers.openlibrary.org/b/id/${work['cover_id']}-M.jpg'
// //                 : 'https://via.placeholder.com/128x193.png?text=No+Cover',
// //             "editionCount": work['edition_count'] ?? 0,
// //             "firstPublishYear": work['first_publish_year'] ?? 0,
// //             "subjects": (work['subject'] as List<dynamic>?)
// //                 ?.map((s) => s.toString())
// //                 .join(', ') ??
// //                 '',
// //           });
// //         }
// //
// //         return books;
// //       } else {
// //         throw Exception("Failed to load books");
// //       }
// //     } catch (e) {
// //       throw Exception("Error fetching books: $e");
// //     }
// //   }
// // }
//
// import 'package:dio/dio.dart';
//
// import '../model/book_model.dart';
//
//
//
// class BookService{
//
//   final Dio _dio= Dio();
//
//   Future<List<Book>> fetchBooksByCategory
//       ( String category ,{int limit = 16 , int offset = 0 } )
//   async {
//     try{
//       final response = await _dio.get(
//         "https://openlibrary.org/subjects/$category.json",
//         queryParameters: {
//           'limit': limit,
//           'offset': offset,
//         },
//       );
//
//
//       if (response.statusCode == 200)
//       {
//         final works = response.data['works'] as List;
//         return works.map((work) => Book.fromJson(work)).toList();
//       }
//       else
//       {
//         throw Exception("Failed to load books");
//       }
//
//     }
//     catch (e){
//       throw Exception("Error Fetching Book :$e");
//     }
//   }
// }
//
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

  // New method to fetch a single book by key, using http package
  Future<Book> fetchBookByKey(String key) async {
    final url = 'https://openlibrary.org$key.json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Book.fromJson(data);
    } else {
      throw Exception('Failed to fetch book with key $key');
    }
  }
}
