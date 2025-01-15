import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movie_ticket_card/movie_ticket_card.dart';
import 'package:movies_app/utils/colors.dart';

import '../utils/Ticket.dart';

import 'package:flutter/material.dart';
import 'package:movie_ticket_card/movie_ticket_card.dart';
import 'package:movies_app/utils/colors.dart';
import 'package:movies_app/utils/Ticket.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/cubit/show_cubit.dart';

import 'package:flutter/material.dart';
import 'package:movie_ticket_card/movie_ticket_card.dart';
import 'package:movies_app/utils/colors.dart';
import 'package:movies_app/utils/Ticket.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/cubit/show_cubit.dart';

import '../utils/shared_preferences_service.dart';

class MyTicketPage extends StatelessWidget {
  const MyTicketPage({super.key});

  void _downloadTicket() {
    // Simulate download functionality
    print('Downloading ticket...');
  }

  @override
  Widget build(BuildContext context) {
    final SharedPreferencesService _prefsService = SharedPreferencesService();

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, // Change back button color to white
        ),
        backgroundColor: AppColors.background,
        title: const Text(
          'My Tickets',
          style: TextStyle(color: AppColors.text),
        ),
      ),
      body: FutureBuilder<List<Ticket>>(
        future: _prefsService.loadTickets(), // Load tickets directly
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error loading tickets: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No Tickets',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            );
          }

          final tickets = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: tickets.length,
            itemBuilder: (context, index) {
              final ticket = tickets[index];
              return Card(
                color: AppColors.accent,
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Center(
                        child: Text(
                          'You can download your E-ticket now!',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      TicketCard(
                        decoration: TicketDecoration(
                            shadow: [
                              TicketShadow(color: Colors.grey, elevation: 30)
                            ],
                            border: TicketBorder(
                                color: AppColors.primary,
                                width: 0.1,
                                style: TicketBorderStyle.dotted)),
                        lineFromTop: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 16),
                            Center(
                              child: Text(
                                ticket.movieTitle,
                                style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.text),
                              ),
                            ),
                            const SizedBox(height: 44),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildTicketDetail('Date', ticket.date),
                                  _buildTicketDetail('Time', ticket.time),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildTicketDetail('Row', ticket.row),
                                  _buildTicketDetail(
                                      'Seats', ticket.seats.join(', ')),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      const Text(
                                        'Add-ons',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      ...ticket.addOns.entries.map((entry) {
                                        return _buildTicketDetail(
                                            entry.key, '\$${entry.value}');
                                      }),
                                    ],
                                  ),
                                  _buildTicketDetail(
                                      "Price", "\$${ticket.price}"),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            Center(
                              child: ElevatedButton(
                                onPressed: _downloadTicket,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32, vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: const Text(
                                  'Download',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildTicketDetail(String label, String value) {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$label: ',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Center(
              child: Text(
                value,
                style: const TextStyle(fontSize: 16, color: AppColors.text),
              ),
            ),
          ],
        )
      ],
    );
  }
}