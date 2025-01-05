import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'MovieCard.dart';

class FavoritePage extends StatelessWidget with MoviePosters {
   FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Top Movies',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...moviePosters.map((movie) {
            return MovieCard(
              movie: movie,
              onRemoveFavorite: () {
                // No action needed (UI-only)
              },
            );
          }).toList(),
        ],
      ),
    );
  }
}