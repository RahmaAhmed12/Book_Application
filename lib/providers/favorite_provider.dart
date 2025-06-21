import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../model/book_model.dart';


class FavoriteNotifier extends StateNotifier<List<Book>> {
  static const String _boxName = 'favoritesBox';
  static const String _favoritesKey = 'favorites';

  late Box _box;

  FavoriteNotifier() : super([]) {
    _box = Hive.box(_boxName);  // get the already opened box synchronously
    final storedBooks = _box.get(_favoritesKey, defaultValue: []) as List<dynamic>;

    final loadedBooks = storedBooks
        .map((e) => Book.fromJson(Map<String, dynamic>.from(e)))
        .toList();

    state = loadedBooks;
  }

  Future<void> _saveFavorites() async {
    final booksToStore = state.map((book) => book.toJson()).toList();
    await _box.put(_favoritesKey, booksToStore);
  }

  void toggleFavorite(Book book) {
    if (state.any((b) => b.key == book.key)) {
      state = state.where((b) => b.key != book.key).toList();
    } else {
      state = [...state, book];
    }
    _saveFavorites();
  }
}

final favoritesProvider =
StateNotifierProvider<FavoriteNotifier, List<Book>>((ref) {
  return FavoriteNotifier();
});