// providers/book_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/book_model.dart';
import '../API/book_service.dart';

class BookCategoryState {
  final List<Book> books;
  final int offset;
  final bool isLoading;

  BookCategoryState({
    this.books = const [],
    this.offset = 0,
    this.isLoading = false,
  });

  BookCategoryState copyWith({
    List<Book>? books,
    int? offset,
    bool? isLoading,
  }) {
    return BookCategoryState(
      books: books ?? this.books,
      offset: offset ?? this.offset,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class BookCategoryNotifier extends StateNotifier<Map<String, BookCategoryState>> {
  BookCategoryNotifier() : super({});

  final BookService _bookService = BookService();
  final int limit = 10;

  Future<void> fetchBooks(String category) async {
    final currentState = state[category] ?? BookCategoryState();

    if (currentState.isLoading) return;

    state = {
      ...state,
      category: currentState.copyWith(isLoading: true),
    };

    final newBooks = await _bookService.fetchBooksByCategory(
      category,
      limit: limit,
      offset: currentState.offset,
    );

    final updatedBooks = [...currentState.books, ...newBooks];

    state = {
      ...state,
      category: BookCategoryState(
        books: updatedBooks,
        offset: currentState.offset + limit,
        isLoading: false,
      ),
    };
  }
}

final bookCategoryProvider = StateNotifierProvider<BookCategoryNotifier, Map<String, BookCategoryState>>(
      (ref) => BookCategoryNotifier(),
);
