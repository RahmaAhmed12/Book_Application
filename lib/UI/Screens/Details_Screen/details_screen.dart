
import 'package:book_application1/Core/theme/App_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../API/book_details_service.dart';
import '../../../model/book_details_model.dart';
import '../../../model/book_model.dart';
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


            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    book.title,
                    style: AppStyle.detailsTittle
                  ),
                ),
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.bookmark : Icons.bookmark_border,
                    color: Colors.deepOrange,
                    size: 25,
                  ),
                  onPressed: () {
                    ref.read(favoritesProvider.notifier).toggleFavorite(book);
                  },
                ),
              ],
            ),
            const SizedBox(height: 5),

            Text(" By ${book.author}", style:AppStyle.greyText18),
            const SizedBox(height: 18),

            detailRow("Subjects: "," ${book.subjects}"),
            const SizedBox(height: 10),

            detailRow("Publish Year: "," ${book.firstPublishYear}"),
            const SizedBox(height: 10),

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

                  // UI display only
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (details.numberOfPages != null)
                        detailRow("Pages:","${details.numberOfPages}"),
                      SizedBox(height: 10,),
                      if (details.language != null)
                        detailRow("Language:"," ${extractAfterSecondSlash(details.language)}"),
                      SizedBox(height: 10,),
                      if (details.notes != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: detailRow("Notes:","${details.notes}"),
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


///----------------------------------------------------
///---------Functions
Widget detailRow(String label, String value) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: AppStyle.detailsBodyBold),
      const SizedBox(width: 4), // spacing between label and value
      Expanded(
        child: Text(
          value,
          style: AppStyle.detailsBody,
          softWrap: true,
        ),
      ),
    ],
  );
}

String extractAfterSecondSlash(String? input) {
  if (input == null || input.isEmpty) return '-';
  final parts = input.split('/');
  if (parts.length > 2) {
    return parts.sublist(2).join('/');
  }
  return input;
}

