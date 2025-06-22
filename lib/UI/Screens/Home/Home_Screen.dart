// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
//
// import '../../../API/book_service.dart';
// import '../../../Core/theme/App_style.dart';
// import '../../../model/book_model.dart';
// import '../../shared widgets/book_card.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
//   final List<String> categories = ['art', 'work', 'romance', 'history','health','fantasy','music'];
//   final Map<String, List<Book>> booksByCategory = {};
//   final Map<String, int> offsets = {};
//   final Map<String, ScrollController> controllers = {};
//   final int limit = 10;
//   bool isLoading = false;
//
//   late TabController _tabController;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Initialize TabController
//     _tabController = TabController(length: categories.length, vsync: this);
//
//
//     // Initialize maps and load first category only
//     for (final category in categories) {
//       offsets[category] = 0;
//       booksByCategory[category] = [];
//       controllers[category] = ScrollController();
//
//       // Add scroll listener
//       controllers[category]!.addListener(() {
//         if (controllers[category]!.position.pixels >=
//             controllers[category]!.position.maxScrollExtent - 300 &&
//             !isLoading) {
//           _loadBooks(category);
//         }
//       });
//     }
//
//     // Load the initial tab only
//     _loadBooks(categories[0]);
//
//     // Listen to tab changes to load the selected tab
//     _tabController.addListener(() {
//       if (_tabController.indexIsChanging) return; // skip during animation
//       final selectedCategory = categories[_tabController.index];
//       if (booksByCategory[selectedCategory]!.isEmpty && !isLoading) {
//         _loadBooks(selectedCategory);
//       }
//     });
//   }
//
//   Future<void> _loadBooks(String category) async {
//     setState(() => isLoading = true);
//
//     final newOffset = offsets[category]!;
//     final newBooks = await BookService()
//         .fetchBooksByCategory(category, limit: limit, offset: newOffset);
//
//     setState(() {
//       booksByCategory[category]!.addAll(newBooks);
//       offsets[category] = newOffset + limit;
//       isLoading = false;
//     });
//   }
//
//   Widget _buildCategoryList(String category) {
//     final books = booksByCategory[category]!;
//
//     if (books.isEmpty && !isLoading) {
//       return const Center(
//         child: Text(
//           'No books available in this category.',
//           style: TextStyle(fontSize: 16, color: Colors.grey),
//         ),
//       );
//     }
//
//     return ListView.builder(
//       controller: controllers[category],
//       itemCount: books.length + 1,
//       itemBuilder: (context, index) {
//         if (index < books.length) {
//           final book = books[index];
//           return BookCard(
//             title: book.title,
//             author: book.author,
//             imageUrl: book.imageURL,
//             onTap: () => context.pushNamed("/details", extra: book),
//           );
//         } else {
//           return isLoading
//               ? const Padding(
//             padding: EdgeInsets.symmetric(vertical: 16),
//             child: Center(child: CircularProgressIndicator()),
//           )
//               : const SizedBox.shrink();
//         }
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title:  Padding(
//           padding: EdgeInsets.only(left: 80),
//           child: Text(
//             "Book Haven",
//             style: AppStyle.textHeader,
//           ),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () => context.pushNamed("/favorite"),
//             icon: const Icon(
//               Icons.favorite,
//               size: 32,
//               color: Colors.deepOrange,
//             ),
//           ),
//         ],
//         bottom: TabBar(
//           controller: _tabController,
//           isScrollable: true, // 👈 Add this line
//           labelColor: Colors.teal,
//           unselectedLabelColor: Colors.grey,
//           indicatorColor: Colors.teal,
//           tabs: categories.map((cat) => Tab(text: cat)).toList(),
//         ),
//
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: categories.map((category) {
//           return _buildCategoryList(category);
//         }).toList(),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     for (final controller in controllers.values) {
//       controller.dispose();
//     }
//     _tabController.dispose();
//     super.dispose();
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../API/book_service.dart';
import '../../../Core/theme/App_style.dart';
import '../../../model/book_model.dart';
import '../../../providers/books_provider.dart';
import '../../shared widgets/book_card.dart';


class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with TickerProviderStateMixin {
  final List<String> categories = [ 'romance','fantasy', 'history','music','cooking','work', 'health',];
  final Map<String, ScrollController> controllers = {};
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: categories.length, vsync: this);

    for (final category in categories) {
      controllers[category] = ScrollController();
      controllers[category]!.addListener(() {
        final state = ref.read(bookCategoryProvider)[category];
        if (controllers[category]!.position.pixels >=
            controllers[category]!.position.maxScrollExtent - 300 &&
            state != null &&
            !state.isLoading) {
          ref.read(bookCategoryProvider.notifier).fetchBooks(category);
        }
      });
    }

    //  Wait until the widget is built to fetch the first tab's books
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(bookCategoryProvider.notifier).fetchBooks(categories[0]);
    });

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      final selectedCategory = categories[_tabController.index];
      final state = ref.read(bookCategoryProvider)[selectedCategory];
      if (state == null || state.books.isEmpty) {
        ref.read(bookCategoryProvider.notifier).fetchBooks(selectedCategory);
      }
    });
  }


  Widget _buildCategoryList(String category) {
    final categoryState = ref.watch(bookCategoryProvider)[category] ?? BookCategoryState();

    // 🔄 First-time loading or empty state handling
    if (categoryState.books.isEmpty) {
      if (categoryState.isLoading) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return const Center(
          child: Text(
            'No books available in this category.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        );
      }
    }


    return ListView.builder(
      controller: controllers[category],
      itemCount: categoryState.books.length + (categoryState.isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < categoryState.books.length) {
          final book = categoryState.books[index];
          return BookCard(
            title: book.title,
            author: book.author,
            imageUrl: book.imageURL,
            onTap: () => context.pushNamed("/details", extra: book),
          );
        } else {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 80),
          child: Text("Book Haven", style: AppStyle.textHeader),
        ),
        actions: [
          IconButton(
            onPressed: () => context.pushNamed("/favorite"),
            icon: const Icon(Icons.favorite, size: 32, color: Colors.deepOrange),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: Colors.teal,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.teal,
          tabs: categories.map((cat) => Tab(text: cat)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: categories.map((category) => _buildCategoryList(category)).toList(),
      ),
    );
  }

  @override
  void dispose() {
    for (final controller in controllers.values) {
      controller.dispose();
    }
    _tabController.dispose();
    super.dispose();
  }
}
