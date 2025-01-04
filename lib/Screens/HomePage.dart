import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies_app/Screens/FavouritePage.dart';
import 'package:movies_app/utils/Movie.dart';
import 'package:movies_app/utils/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'ProfilePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();

  int _currentIndex = 0; // Track the selected index
  final _iconList = [
    FontAwesomeIcons.house,
    FontAwesomeIcons.film,
    FontAwesomeIcons.heart,
    FontAwesomeIcons.person,
  ];

  final _pages = [
     HomeScreen(),
     ProfilePage(),
     FavoritePage(),
     ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          color: Colors.white,
          icon: const Icon(Icons.menu),
          onPressed: () {
            scaffoldkey.currentState!.openDrawer();
          },
        ),
        backgroundColor: AppColors.background,
        actions: [
          IconButton(
            color: Colors.white,
            icon: const FaIcon(FontAwesomeIcons.bell),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Notifications clicked")),
              );
            },
          ),
          IconButton(
            color: Colors.white,
            icon: const FaIcon(FontAwesomeIcons.magnifyingGlass),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Search clicked")),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                setState(() {
                  _currentIndex = 0; // Switch to Home screen
                });
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.airplane_ticket_outlined),
              title: const Text('Your Tickets'),
              onTap: () {
                setState(() {
                  _currentIndex = 1; // Switch to Search screen
                });
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                setState(() {
                  _currentIndex = 3; // Switch to Profile screen
                });
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: _iconList,
        activeIndex: _currentIndex,
        backgroundColor: AppColors.accent,
        activeColor: AppColors.primary,
        inactiveColor: AppColors.text,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        child: const FaIcon(FontAwesomeIcons.ticket),
        onPressed: () {
          // Action for Floating Action Button
          // Navigator.of(context).push(TicketPage())
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: _pages[_currentIndex],
    );
  }
}

class HomeScreen extends StatefulWidget with MoviePosters {
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _carousalIndex = 0;
  Set<int> favorites = {}; // Track favorite movies

  @override
  Widget build(BuildContext context) {
    final movie = widget.moviePosters[_carousalIndex];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Now Playing Text
              const Padding(
                padding: EdgeInsets.only(left: 16, top: 16),
                child: Text(
                  "Now Playing:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),

              // Carousel
              CarouselSlider.builder(
                itemCount: widget.moviePosters.length,
                options: CarouselOptions(
                  height: 400,
                  viewportFraction: 0.65,
                  enableInfiniteScroll: true,
                  autoPlay: false,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _carousalIndex = index;
                    });
                  },
                ),
                itemBuilder: (context, index, realIndex) {
                  final movie = widget.moviePosters[index];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      movie.imagePath,
                      fit: BoxFit.cover,
                      height: 350,
                      width: 200,
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),

              // Movie Details
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      movie.subtitle,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      movie.duration,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      movie.summary,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Add button action here
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                          ),
                          child: const Text("Book Now"),
                        ),
                        const SizedBox(width: 16),
                        IconButton(
                          icon: Icon(
                            favorites.contains(_carousalIndex)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            setState(() {
                              if (favorites.contains(_carousalIndex)) {
                                favorites.remove(_carousalIndex);
                              } else {
                                favorites.add(_carousalIndex);
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

mixin MoviePosters {
  final List<Movie> moviePosters = [
    Movie('Oppenheimer', 'Drama', 'Duration: 1h 46m', "Summary",
        'images/opennhimer.jpg'),
    Movie('Blade runner', 'Drama', 'Duration: 2h 55m', "Summary",
        'images/bladerunner.jpg'),
    Movie('Joker', 'Drama, Action', 'Duration: 1h 22m', "Summary", 'images/joker.jpg'),
    Movie('Gladiator', 'Action', 'Duration: 2h 46m', "Summary",
        'images/gladiator.jpg'),
    Movie(
        'Matrix', 'Action', 'Duration: 1h 57m', "Summary", 'images/matrix.jpg'),
  ];
}