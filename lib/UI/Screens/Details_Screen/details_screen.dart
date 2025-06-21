//
//
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
//
// import '../../../API/book_details_service.dart';
//
// import '../../../Core/theme/App_colors.dart';
// import '../../../Core/theme/App_style.dart';
//
// import '../../../model/book_model.dart';
// import '../../../model/book_details_model.dart';
//
//
//
//
//
//
// class DetailsScreen extends StatelessWidget {
//   const DetailsScreen({super.key});
//
//   Future<BookDetails?> _fetchBookDetails(String bookId) async {
//     final service = BookDetailsService();
//     return await service.fetchBookDetails(bookId);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final book = GoRouterState.of(context).extra as Book;
//
//     return Scaffold(
//       appBar: AppBar(
//         title:  Text("Details", style: AppStyle.detailsHeader,),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // image
//             Center(
//                 child:Image.network(
//                   book.imageURL,
//                   height: 250,
//                   fit: BoxFit.contain,
//                   errorBuilder: (context, error, stackTrace) {
//                     return const Icon(Icons.image_not_supported, size: 100, color: Colors.grey);
//                   },
//                 )
//
//             ),
//             const SizedBox(height: 16),
//             // Tittle & Icon
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: Text(
//                     book.title,
//                     style: const TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     softWrap: true, // Optional, true by default
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.bookmark_border, color: AppColors.deepOrange, size: 30),
//                   onPressed: () {},
//                 ),
//               ],
//             ),
//
//
//
//             const SizedBox(height: 8),
//             // Author
//             Text(
//               book.author,
//               style: const TextStyle(fontSize: 18, color: Colors.grey),
//             ),
//             const SizedBox(height: 16),
//             //Publish Year
//             Text(
//               "Publish Year : ${book.firstPublishYear?? '-'}",
//               style: const TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 8),
//             // Book Subjects
//             Text(
//               "Subjects: ${book.subjects}",
//               style: const TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 24),
//             Text("-----------------------------------------------------"),
//
//             // Fetch full details if coverEditionKey exists
//             if (book.coverEditionKey != null)
//               FutureBuilder<BookDetails?>(
//                 future: _fetchBookDetails(book.coverEditionKey!),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     return Text("Error loading full details: ${snapshot.error}");
//                   } else if (!snapshot.hasData || snapshot.data == null) {
//                     return const Text("No additional details found.");
//                   }
//
//                   final details = snapshot.data!;
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       if (details.publishDate != null)
//                         Text("Published: ${details.publishDate}"),
//                       if (details.numberOfPages != null)
//                         Text("Pages: ${details.numberOfPages}"),
//                       if (details.genres != null)
//                         Text("Genres: ${details.genres}"),
//                       if (details.language != null)
//                         Text("Language: ${details.language}"),
//                       if (details.notes != null)
//                         Padding(
//                           padding: const EdgeInsets.only(top: 12),
//                           child: Text(
//                             "Notes: ${details.notes}",
//                             style: const TextStyle(fontStyle: FontStyle.italic),
//                           ),
//                         ),
//                     ],
//                   );
//                 },
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:book_application1/Core/theme/App_colors.dart';
import 'package:book_application1/Core/theme/App_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../API/book_details_service.dart';
import '../../../model/book_details_model.dart';
import '../../../model/book_model.dart';


import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/favorite_provider.dart';


class DetailsScreen extends ConsumerWidget {
  const DetailsScreen({super.key});

  Future<BookDetails?> _fetchBookDetails(String bookId) async {
    final service = BookDetailsService();
    return await service.fetchBookDetails(bookId);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final book = GoRouterState.of(context).extra as Book;
    final favorites = ref.watch(favoritesProvider);
    final isFavorite = favorites.any((b) => b.key == book.key);


    return Scaffold(
      appBar: AppBar(
        title: Text("Details", style: AppStyle.detailsHeader),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // image
            Center(
              child: Image.network(
                book.imageURL,
                height: 250,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.image_not_supported, size: 100, color: Colors.grey);
                },
              ),
            ),
            const SizedBox(height: 16),

            // Title & Favorite Icon
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    book.title,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                // IconButton(
                //   icon: Icon(
                //     isFavorite ? Icons.bookmark : Icons.bookmark_border,
                //     color: AppColors.deepOrange,
                //     size: 30,
                //   ),
                //   onPressed: () {
                //     ref.read(favoritesProvider.notifier).toggleFavorite(book);
                //   },
                // ),
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.bookmark : Icons.bookmark_border,
                    color: Colors.deepOrange,
                  ),
                  onPressed: () {
                    ref.read(favoritesProvider.notifier).toggleFavorite(book);
                  },
                ),

              ],
            ),

            const SizedBox(height: 8),
            Text(book.author, style: const TextStyle(fontSize: 18, color: Colors.grey)),
            const SizedBox(height: 16),
            Text("Publish Year : ${book.firstPublishYear ?? '-'}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Subjects: ${book.subjects}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 24),
            const Text("-----------------------------------------------------"),

            if (book.coverEditionKey != null)
              FutureBuilder<BookDetails?>(
                future: _fetchBookDetails(book.coverEditionKey!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text("Error loading full details: ${snapshot.error}");
                  } else if (!snapshot.hasData) {
                    return const Text("No additional details found.");
                  }

                  final details = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (details.publishDate != null) Text("Published: ${details.publishDate}"),
                      if (details.numberOfPages != null) Text("Pages: ${details.numberOfPages}"),
                      if (details.genres != null) Text("Genres: ${details.genres}"),
                      if (details.language != null) Text("Language: ${details.language}"),
                      if (details.notes != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text(
                            "Notes: ${details.notes}",
                            style: const TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                    ],
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}