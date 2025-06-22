// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../Core/theme/App_style.dart';
// import '../../../providers/favorite_provider.dart';
//
//
// class FavoriteScreen extends ConsumerWidget {
//   const FavoriteScreen({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final favoriteBooks = ref.watch(favoritesProvider);
//     final favoriteNotifier = ref.read(favoritesProvider.notifier);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Favorite", style: AppStyle.textHeader),
//         centerTitle: true,
//       ),
//       body: favoriteBooks.isEmpty
//           ? const Center(child: Text("No favorite books yet."))
//           : ListView.builder(
//         itemCount: favoriteBooks.length,
//         itemBuilder: (context, index) {
//           final book = favoriteBooks[index];
//           return ListTile(
//             title: Row(
//               children: [
//                 i
//                 Text(book.title),
//               ],
//             ),
//             trailing: IconButton(
//               icon: const Icon(Icons.delete, color: Colors.red),
//               onPressed: () {
//                 favoriteNotifier.removeFavorite(book); // ✅ remove from favorites
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text('${book.title} removed from favorites')),
//                 );
//               },
//             ),
//             // onTap removed
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../Core/assets/App_assets.dart';
import '../../../Core/theme/App_style.dart';
import '../../../Core/theme/App_colors.dart';
import '../../../providers/favorite_provider.dart';
import '../../../model/book_model.dart';

class FavoriteScreen extends ConsumerWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteBooks = ref.watch(favoritesProvider);
    final favoriteNotifier = ref.read(favoritesProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites", style: AppStyle.textHeader),
        centerTitle: true,
      ),
      body: favoriteBooks.isEmpty
          ?  Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Image.asset(AppAssets.story, height: 200 ,color: AppColors.lightGrey,),
          )
      )
          : ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: favoriteBooks.length,
        itemBuilder: (context, index) {
          final Book book = favoriteBooks[index];

          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
                leading: book.coverEditionKey != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://covers.openlibrary.org/b/olid/${book.coverEditionKey}-M.jpg',
                    width: 50,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                  ),
                )
                    : const Text(""),

              title: Text(
                book.title,
                style: AppStyle.darkBlueText18,
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: AppColors.deepOrange),
                onPressed: () {
                  favoriteNotifier.removeFavorite(book);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${book.title} removed from favorites')),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
