import 'package:flutter/material.dart';
import '../cubit/show_cubit.dart';
import 'MovieCard.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Add BLoC for state management

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    context.read<ShowCubit>().getShows(1);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ShowCubit, ShowState>(
        builder: (context, state) {
          if (state is ShowLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ShowLoaded) {
            final movies = state.shows; // Access the list of shows from the state
            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return MovieCard(
                  onTap: () {
                    // Handle tap action (e.g., navigate to details page)
                  },
                  showModels: movie,
                );
              },
            );
          } else if (state is ShowLoadFailed) {
            return Center(
              child: Text('Failed to load movies: ${state.message}'),
            );
          } else {
            return const Center(child:CircularProgressIndicator());
          }
        },
      ),
    );
  }
}