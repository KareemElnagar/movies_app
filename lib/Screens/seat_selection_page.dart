import 'package:flutter/material.dart';
import 'package:book_my_seat/book_my_seat.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/cubit/show_cubit.dart';
import 'package:movies_app/utils/colors.dart';
import '../models/show_models.dart';
import '../utils/custom_paint.dart';
import '../utils/Ticket.dart';
import 'MyTicketPage.dart'; // Import the Ticket model

class SeatSelectionPage extends StatefulWidget {
  const SeatSelectionPage({super.key, required this.movie});
  final ShowModels movie;

  @override
  _SeatSelectionPageState createState() => _SeatSelectionPageState();
}

class _SeatSelectionPageState extends State<SeatSelectionPage> {
  List<DateTime> dates = [
    DateTime.now(),
    DateTime.now().add(const Duration(days: 1)),
    DateTime.now().add(const Duration(days: 2)),
    DateTime.now().add(const Duration(days: 3)),
    DateTime.now().add(const Duration(days: 4)),
    DateTime.now().add(const Duration(days: 5)),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowCubit, ShowState>(
      builder: (context, state) {
        if (state is ShowLoaded) {
          final selectedShow = widget.movie;
          final selectedSeats = state.selectedSeats;
          final selectedDate = state.selectedDate;

          // Calculate total price
          final double seatPrice = 15.00; // Price per seat
          final double totalPrice = selectedSeats.length * seatPrice;

          return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(
                color: Colors.white, // Change back button color to white
              ),
              backgroundColor: AppColors.background,
              title: Text(
                selectedShow.name,
                style: const TextStyle(color: AppColors.text),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date Selection
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: dates.asMap().entries.map((entry) {
                          final index = entry.key;
                          final date = entry.value;
                          final isSelected = date == selectedDate;
                          return GestureDetector(
                            onTap: () {
                              context.read<ShowCubit>().updateSelectedDate(date);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 16),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primary
                                    : Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    _getDayOfWeek(date.weekday),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    date.day.toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Container(
                        width: 320,
                        height: 50,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.2),
                              spreadRadius: 3,
                              blurRadius: 50,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                        child: const CurvedLine(
                          width: 320,
                          height: 2,
                          color: AppColors.primary,
                          strokeWidth: 5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Center(
                      child: Text(
                        'Screen', // Cinema name
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Seat Layout
                    SeatLayoutWidget(
                      stateModel: const SeatLayoutStateModel(
                        rows: 10,
                        cols: 7,
                        seatSvgSize: 45,
                        pathSelectedSeat: 'images/seatselected.svg',
                        pathSoldSeat: 'images/seat.svg',
                        pathDisabledSeat: 'images/seat.svg',
                        currentSeatsState: [
                          [
                            SeatState.sold,
                            SeatState.unselected,
                            SeatState.unselected,
                            SeatState.unselected,
                            SeatState.sold,
                            SeatState.unselected,
                            SeatState.sold,
                            SeatState.unselected,
                            SeatState.sold,
                            SeatState.unselected,
                          ],
                          [
                            SeatState.unselected,
                            SeatState.sold,
                            SeatState.empty,
                            SeatState.disabled,
                            SeatState.sold,
                            SeatState.unselected,
                            SeatState.sold,
                            SeatState.unselected,
                            SeatState.sold,
                            SeatState.unselected,
                          ],
                          [
                            SeatState.sold,
                            SeatState.unselected,
                            SeatState.sold,
                            SeatState.empty,
                            SeatState.disabled,
                            SeatState.unselected,
                            SeatState.sold,
                            SeatState.unselected,
                            SeatState.sold,
                            SeatState.unselected,
                          ],
                          [
                            SeatState.unselected,
                            SeatState.sold,
                            SeatState.unselected,
                            SeatState.sold,
                            SeatState.empty,
                            SeatState.disabled,
                            SeatState.sold,
                            SeatState.unselected,
                            SeatState.sold,
                            SeatState.unselected,
                          ],
                          [
                            SeatState.sold,
                            SeatState.unselected,
                            SeatState.sold,
                            SeatState.unselected,
                            SeatState.sold,
                            SeatState.empty,
                            SeatState.disabled,
                            SeatState.unselected,
                            SeatState.sold,
                            SeatState.unselected,
                          ],
                          [
                            SeatState.unselected,
                            SeatState.sold,
                            SeatState.unselected,
                            SeatState.sold,
                            SeatState.unselected,
                            SeatState.sold,
                            SeatState.empty,
                            SeatState.disabled,
                            SeatState.sold,
                            SeatState.unselected,
                          ],
                          [
                            SeatState.sold,
                            SeatState.unselected,
                            SeatState.sold,
                            SeatState.unselected,
                            SeatState.sold,
                            SeatState.unselected,
                            SeatState.sold,
                            SeatState.empty,
                            SeatState.disabled,
                            SeatState.unselected,
                          ],
                          [
                            SeatState.unselected,
                            SeatState.sold,
                            SeatState.unselected,
                            SeatState.sold,
                            SeatState.unselected,
                            SeatState.sold,
                            SeatState.unselected,
                            SeatState.sold,
                            SeatState.empty,
                            SeatState.disabled,
                          ],
                          [
                            SeatState.sold,
                            SeatState.unselected,
                            SeatState.sold,
                            SeatState.unselected,
                            SeatState.sold,
                            SeatState.unselected,
                            SeatState.sold,
                            SeatState.unselected,
                            SeatState.sold,
                            SeatState.empty,
                          ],
                          [
                            SeatState.empty,
                            SeatState.disabled,
                            SeatState.unselected,
                            SeatState.sold,
                            SeatState.unselected,
                            SeatState.sold,
                            SeatState.unselected,
                            SeatState.sold,
                            SeatState.unselected,
                            SeatState.sold,
                          ],
                        ],
                        pathUnSelectedSeat: 'images/seatwhite.svg',
                      ),
                      onSeatStateChanged: (int row, int col, SeatState currentState) {
                        final seatId = row * 7 + col + 1; // Assuming 7 columns
                        if (currentState == SeatState.selected || currentState == SeatState.unselected) {
                          context.read<ShowCubit>().toggleSeatSelection(seatId);
                        }
                      },
                    ),
                    const SizedBox(height: 16),

                    // Seat Status Legend
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSeatStatus('Available', Colors.white),
                        _buildSeatStatus('Taken', Colors.black),
                        _buildSeatStatus('Selected', AppColors.primary),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15), // Circular edges
                      ),
                      color: Colors.grey[800], // Grey background color
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Location Icon and Cinema Name
                            const Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.white, // Location icon color
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'San Stefano Cinema', // Cinema name
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

                            // Cinema Location
                            Text(
                              'Mykola Owodova street, 51. Vinnitsa, Vinnitsa region, 21000',
                              // Cinema location
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  if (selectedSeats.isNotEmpty) {
                                    // Create a Ticket object
                                    final ticket = Ticket(
                                      movieTitle: selectedShow.name,
                                      date: selectedDate.toLocal().toString(),
                                      time: '18:50 p.m', // Example: Hardcoded time
                                      row: '2', // Example: Hardcoded row
                                      seats: selectedSeats,
                                      addOns: {'POP CORN(1)': 5.0}, // Example: Hardcoded add-ons
                                      price: totalPrice,
                                    );

                                    // Add the ticket to the state
                                    context.read<ShowCubit>().addTicket(ticket);
                                    context.read<ShowCubit>().resetSelection();

                                    // Show a success message
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Ticket purchased successfully!'),
                                      ),
                                    );

                                    // Navigate to MyTicketPage
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const MyTicketPage(),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Please select at least one seat.'),
                                      ),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32, vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Text(
                                  'Buy Ticket \$${totalPrice.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state is ShowLoadFailed) {
          return Center(
            child: Text('Failed to load Show: ${state.message}'),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  String _getDayOfWeek(int weekday) {
    switch (weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  Widget _buildSeatStatus(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(fontSize: 14, color: color),
        ),
      ],
    );
  }
}