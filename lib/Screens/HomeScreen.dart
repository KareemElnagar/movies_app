import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/Screens/MovieCard.dart';
import 'package:movies_app/Screens/seat_selection_page.dart';
import 'package:movies_app/cubit/show_cubit.dart';
import 'package:movies_app/models/show_models.dart';
import 'package:movies_app/utils/Movie.dart';

import '../utils/colors.dart';
import 'ShowDetailsPage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _carouselIndex = 0;
  final Set<int> _favorites = {}; // Local favorites list
  ShowModels? selectedShow;

  void _toggleFavorite(int index) {
    setState(() => _favorites.contains(index)
        ? _favorites.remove(index)
        : _favorites.add(index));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<ShowCubit>().getShows(3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ShowCubit, ShowState>(builder: (context, state) {
        if (state is ShowLoaded) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 16, top: 16),
                    child: Text(
                      "Now Playing:",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildCarousel(),
                  const SizedBox(height: 16),
                  _buildMovieDetails(),
                ],
              ),
            ),
          );
        } else if (state is ShowLoading) {
          return CircularProgressIndicator();
        } else if (state is ShowLoadFailed) {
          return Text("No Data");
        } else {
         return Center(child: CircularProgressIndicator());
        }
      }),
    );
  }

  Widget _buildCarousel() {
    return BlocBuilder<ShowCubit, ShowState>(
      builder: (context, state) {
        if (state is ShowLoaded) {
          return Column(
            children: [
              CarouselSlider.builder(
                itemCount: state.shows.length,
                options: CarouselOptions(
                  height: 400,
                  viewportFraction: 0.65,
                  enableInfiniteScroll: true,
                  autoPlay: false,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) =>
                      setState(() => _carouselIndex = index),
                ),
                itemBuilder: (context, index, realIndex) {
                  final movie = state.shows[index];
                  return _buildMoviePoster(movie);
                },
              ),
              const SizedBox(height: 10),
              Text('Page ${_carouselIndex + 1} of ${state.shows.length}'),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildMoviePoster(ShowModels showModel) {
    return BlocBuilder<ShowCubit, ShowState>(
      builder: (context, state) {
        if (state is ShowLoaded) {
          final movie = showModel; // Access the movie from the API data
          return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              movie.image,
              fit: BoxFit.cover,
              width: 400,
              height: 250,
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
        } else if (state is ShowLoadFailed) {
          return Center(
            child: Text('Failed to load movie details: ${state.message}'),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildMovieDetails() {
    return BlocBuilder<ShowCubit, ShowState>(
      builder: (context, state) {
        if (state is ShowLoaded) {
          final movie =
              state.shows[_carouselIndex]; // Access the movie from the API data

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  movie.name, // Use API field names
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  movie.network ?? 'N/A', // Handle nullable fields
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Text(
                  movie.country ?? 'N/A', // Handle nullable fields
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Text(
                  movie.startDate ?? 'No summary available',
                  // Handle nullable fields
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 16),
                _buildActionButtons(movie),
                const SizedBox(height: 40),
              ],
            ),
          );
        } else if (state is ShowLoadFailed) {
          return Center(
            child: Text('Failed to load movie details: ${state.message}'),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildActionButtons(ShowModels movie) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SeatSelectionPage(movie: movie,)),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          child: const Text("Book Now"),
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}
