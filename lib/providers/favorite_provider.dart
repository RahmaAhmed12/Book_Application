//
//
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hive/hive.dart';
// import '../model/book_model.dart';
//
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hive/hive.dart';
// import '../model/book_model.dart';
//
// class FavoriteNotifier extends StateNotifier<List<Book>> {
//   static const String _boxName = 'favoritesBox';
//   static const String _favoritesKey = 'favorites';
//
//   late final Box _box;
//
//   FavoriteNotifier() : super([]) {
//     _init();
//   }
//
//   Future<void> _init() async {
//     _box = Hive.box(_boxName);
//     final storedBooks = _box.get(_favoritesKey, defaultValue: []) as List<dynamic>;
//     final loadedBooks = storedBooks
//         .map((e) => Book.fromJson(Map<String, dynamic>.from(e)))
//         .toList();
//     state = loadedBooks;
//   }
//
//   Future<void> _saveFavorites() async {
//     final booksToStore = state.map((book) => book.toJson()).toList();
//     await _box.put(_favoritesKey, booksToStore);
//   }
//
//   void toggleFavorite(Book book) {
//     if (state.any((b) => b.key == book.key)) {
//       state = state.where((b) => b.key != book.key).toList();
//     } else {
//       state = [...state, book];
//     }
//     _saveFavorites();
//   }
// }
//
// final favoritesProvider = StateNotifierProvider<FavoriteNotifier, List<Book>>((ref) {
//   return FavoriteNotifier();
// });
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';


import '../model/with hive/favorate_book.dart';
import '../model/with hive/favorate_book_details.dart';

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, List<FavBook>>((ref) {
  return FavoritesNotifier();
});

class FavoritesNotifier extends StateNotifier<List<FavBook>> {
  FavoritesNotifier() : super(Hive.box<FavBook>('favoritesBox').values.toList());

  final _favBox = Hive.box<FavBook>('favoritesBox');
  final _detailsBox = Hive.box<FavBookDetails>('detailsBox');

  void toggleFavorite(FavBook book, [FavBookDetails? details]) {
    final isAlreadyFav = _favBox.containsKey(book.key);
    if (isAlreadyFav) {
      _favBox.delete(book.key);
      _detailsBox.delete(book.key);
    } else {
      _favBox.put(book.key, book);
      if (details != null) {
        _detailsBox.put(book.key, details);
      }
    }
    state = _favBox.values.toList(); // Update UI
  }

  FavBookDetails? getDetails(String key) {
    return _detailsBox.get(key);
  }
}
