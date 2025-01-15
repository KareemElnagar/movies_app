import 'package:flutter/material.dart';
import 'package:movies_app/Screens/seat_selection_page.dart';
import 'package:movies_app/models/show_models.dart';
import 'package:movies_app/services/services.dart';
import '../models/show_details_model.dart';
import '../utils/colors.dart';

class ShowDetailsPage extends StatefulWidget {
  final ShowModels movie;

  const ShowDetailsPage({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  State<ShowDetailsPage> createState() => _ShowDetailsPageState();
}

class _ShowDetailsPageState extends State<ShowDetailsPage> {
  bool isLoading = true;
  ShowDetailsModels? showDetails;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchShowDetails();
  }

  Future<void> fetchShowDetails() async {
    try {
      // Call the API to fetch additional details
      final details = await ShowServices.getShowDetails(widget.movie);
      setState(() {
        showDetails = details;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load show details.';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              widget.movie.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            backgroundColor: AppColors.primary,
            pinned: true,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.movie.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : errorMessage.isNotEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            errorMessage,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.movie.name,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.calendar_today,
                                    size: 16, color: Colors.grey),
                                SizedBox(width: 4),
                                Text(
                                  widget.movie.startDate,
                                  style: TextStyle(color: Colors.grey),
                                ),
                                SizedBox(width: 16),
                                Icon(Icons.star, size: 16, color: Colors.amber),
                                SizedBox(width: 4),
                                Text(
                                  showDetails?.rating ?? 'N/A',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Genres: ${showDetails?.genres?.join(', ') ?? 'N/A'}',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Description',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              showDetails?.description ??
                                  'No description available.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                              ),
                            ),
                            SizedBox(height: 20),
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  // Perform an action or navigate
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SeatSelectionPage(
                                              movie: widget.movie,
                                            )),
                                  );
                                },
                                child: Text(
                                  'Book',
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
