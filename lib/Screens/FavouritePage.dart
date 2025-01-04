import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import 'HomePage.dart';

class FavoritePage extends StatefulWidget with MoviePosters {
   FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  Set<int> favorites = {0, 2}; // Example: Indices of favorite movies

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        backgroundColor: AppColors.background,
      ),
      body: ListView.builder(
        itemCount: widget.moviePosters.length,
        itemBuilder: (context, index) {
          if (!favorites.contains(index)) {
            return const SizedBox.shrink(); // Skip non-favorite movies
          }
          final movie = widget.moviePosters[index];
          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                movie.imagePath,
                fit: BoxFit.cover,
                width: 50,
                height: 50,
              ),
            ),
            title: Text(movie.title),
            subtitle: Text(movie.subtitle),
            trailing: IconButton(
              icon: const Icon(Icons.favorite, color: Colors.red),
              onPressed: () {
                setState(() {
                  favorites.remove(index); // Remove from favorites
                });
              },
            ),
          );
        },
      ),
    );
  }
}