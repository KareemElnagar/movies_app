import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies_app/Screens/CinemaPage.dart';
import 'package:movies_app/Screens/FavouritePage.dart';
import 'package:movies_app/Screens/ProfilePage.dart';
import 'package:movies_app/Screens/ShowDetailsPage.dart';
import 'package:movies_app/cubit/show_cubit.dart';
import 'package:movies_app/utils/NotificationMenu.dart';
import 'package:movies_app/utils/colors.dart';

import 'HomeScreen.dart';
import 'MyTicketPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentIndex = 0; // Track the selected index

  final List<NotificationMenuModel> notifications = [
    NotificationMenuModel(
      title: 'New Movie Release',
      description: 'Black Adam is now available in your area.',
      time: '2h ago',
    ),
    NotificationMenuModel(
      title: 'Special Offer',
      description: 'Get 50% off on your next booking.',
      time: '1d ago',
      isRead: true,
    ),
    NotificationMenuModel(
      title: 'Reminder',
      description: 'Your booking for The Northman starts in 1 hour.',
      time: '3d ago',
    ),
  ];

  final _iconList = [
    FontAwesomeIcons.house,
    FontAwesomeIcons.film,
    FontAwesomeIcons.heart,
    FontAwesomeIcons.person,
  ];

  final _pages = [
    const HomeScreen(),
    CinemaPage(),
    const FavoritePage(),
    ProfilePage(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
        backgroundColor: AppColors.background,
        actions: [
          _buildNotificationMenu(),
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.magnifyingGlass, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Search clicked")),
              );
            },
          ),
        ],
      ),
      drawer: _buildDrawer(),
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
        onTap: (index) => setState(() => _currentIndex = index),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        child: const FaIcon(FontAwesomeIcons.ticket),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyTicketPage()),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
     // body: _pages[_currentIndex],
      body: BlocBuilder<ShowCubit, ShowState>(
        builder: (context, state) {
          return _pages[_currentIndex];
        },
      ),
    );
  }

  Widget _buildNotificationMenu() {
    return PopupMenuButton<NotificationMenuModel>(
      icon: const FaIcon(FontAwesomeIcons.bell, color: AppColors.text),
      itemBuilder: (context) {
        return notifications.map((notification) {
          return PopupMenuItem(
            value: notification,
            child: ListTile(
              leading: Icon(
                FontAwesomeIcons.bell,
                color: notification.isRead ? Colors.white : AppColors.primary,
              ),
              title: Text(
                notification.title,
                style: TextStyle(
                  fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
                  color: AppColors.text,
                ),
              ),
              subtitle: Text(
                notification.description,
                style: const TextStyle(color: Colors.grey),
              ),
              trailing: Text(
                notification.time,
                style: const TextStyle(color: AppColors.text, fontSize: 12),
              ),
            ),
          );
        }).toList();
      },
      onSelected: (notification) {
        // Handle notification selection
        debugPrint('Selected Notification: ${notification.title}');
      },
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => _navigateToPage(0),
          ),
          ListTile(
            leading: const Icon(Icons.airplane_ticket_outlined),
            title: const Text('Your Tickets'),
            onTap: () => _navigateToPage(1),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () => _navigateToPage(3),
          ),
        ],
      ),
    );
  }

  void _navigateToPage(int index) {
    setState(() => _currentIndex = index);
    Navigator.pop(context); // Close the drawer
  }
}