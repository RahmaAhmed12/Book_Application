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
        title: Padding(
          padding: const EdgeInsets.only(left: 60),
          child: Text("Favorite", style: AppStyle.textHeader),
        ),
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
            subtitle: Text(book.author),
            onTap: () {
              context.pushNamed('/details' ,extra: book);
            },
          );
        },
      ),
    );
  }
}



