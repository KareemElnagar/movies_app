import 'package:flutter/material.dart';
import 'package:book_my_seat/book_my_seat.dart';
import 'package:movies_app/utils/colors.dart';

import '../utils/custom_paint.dart';

class SeatSelectionPage extends StatefulWidget {
  const SeatSelectionPage({super.key});

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

  int selectedDateIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, // Change back button color to white
        ),
        backgroundColor: AppColors.background,
        title: const Text(
          'Matrix',
          style: TextStyle(color: AppColors.text),
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
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDateIndex = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: selectedDateIndex == index
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
                                color: selectedDateIndex == index
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              date.day.toString(),
                              style: TextStyle(
                                fontSize: 16,
                                color: selectedDateIndex == index
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
                onSeatStateChanged:
                    (int rowI, int colI, SeatState currentState) {},
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
                            // Handle buy ticket action
                            print('Buy Ticket');
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
                          child: const Text(
                            'Buy Ticket \$15.00',
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
              ),

              // Buy Ticket Button
            ],
          ),
        ),
      ),
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
