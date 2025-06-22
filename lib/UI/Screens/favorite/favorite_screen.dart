
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../Core/theme/App_style.dart';
import '../../../providers/favorite_provider.dart';

class FavoriteScreen extends ConsumerWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteBooks = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite", style: AppStyle.textHeader),
        centerTitle: true,
      ),
      body: favoriteBooks.isEmpty
          ? const Center(child: Text("No favorite books yet."))
          : ListView.builder(
        itemCount: favoriteBooks.length,
        itemBuilder: (context, index) {
          final book = favoriteBooks[index];
          return ListTile(
            leading: Image.network(
              book.imageURL,
              width: 50,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.image),
            ),
            title: Text(book.title),
            subtitle: Column(
              children: [
                Text(book.author),
                Text(book.key)
              ],
            ),
            onTap: () {
              context.pushNamed('/details', extra: book);
            },
          );
        },
      ),
    );
  }
}

///----------------------------------------///
//
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:hive/hive.dart';
//
// import '../../../Core/theme/App_style.dart';
// import '../../../providers/favorite_provider.dart';
//
// class FavoriteScreen extends ConsumerWidget {
//   const FavoriteScreen({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final favoriteBooks = ref.watch(favoritesProvider);
//
//     // Access raw Hive data
//     final rawHiveData = Hive.box('favoritesBox').get('favorites');
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Favorite", style: AppStyle.textHeader),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           // Section to display raw Hive data
//           if (rawHiveData != null) ...[
//             const SizedBox(height: 10),
//             const Text(
//               "Raw Hive Data:",
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             Container(
//               padding: const EdgeInsets.all(8),
//               margin: const EdgeInsets.symmetric(horizontal: 8),
//               decoration: BoxDecoration(
//                 color: Colors.grey[200],
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               height: 120,
//               child: SingleChildScrollView(
//                 child: Text(rawHiveData.toString()),
//               ),
//             ),
//             const Divider(),
//           ],
//
//           // Section to display favorite books
//           Expanded(
//             child: favoriteBooks.isEmpty
//                 ? const Center(child: Text("No favorite books yet."))
//                 : ListView.builder(
//               itemCount: favoriteBooks.length,
//               itemBuilder: (context, index) {
//                 final book = favoriteBooks[index];
//                 return ListTile(
//                   leading: Image.network(
//                     book.imageURL,
//                     width: 50,
//                     errorBuilder: (context, error, stackTrace) =>
//                     const Icon(Icons.image),
//                   ),
//                   title: Text(book.title),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(book.author),
//                       Text("Key: ${book.key}"),
//                     ],
//                   ),
//                   onTap: () {
//                     //context.pushNamed('/details', extra: book);
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
