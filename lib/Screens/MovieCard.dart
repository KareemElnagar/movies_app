import 'package:flutter/material.dart';
import 'package:movies_app/models/show_details_model.dart';
import 'package:movies_app/models/show_models.dart';
import 'package:movies_app/utils/colors.dart';

class MovieCard extends StatelessWidget {
  final VoidCallback onTap;
  final ShowModels showModels;

  const MovieCard({
    super.key,
    required this.onTap,
    required this.showModels,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.background,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Movie Poster
              _buildMoviePoster(),
              const SizedBox(width: 16),

              // Movie Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitleAndGenre(),
                    const SizedBox(height: 8),
                    _buildRatingAndYear(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMoviePoster() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        showModels.image,
        fit: BoxFit.cover,
        width: 80,
        height: 120,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 80,
            height: 120,
            color: Colors.grey[300],
            child: const Icon(Icons.broken_image, color: Colors.grey),
          );
        },
      ),
    );
  }

  Widget _buildTitleAndGenre() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          showModels.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          showModels.country,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildRatingAndYear() {
    return Row(
      children: [
        const Icon(Icons.star, color: Colors.amber, size: 16),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            showModels?.status ?? 'N/A',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Flexible(
          child: Text(
            showModels.startDate,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

}