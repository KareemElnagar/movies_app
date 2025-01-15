class Ticket {
  final String movieTitle;
  final String date;
  final String time;
  final String row;
  final List<int> seats;
  final Map<String, double> addOns;
  final double price;

  Ticket({
    required this.movieTitle,
    required this.date,
    required this.time,
    required this.row,
    required this.seats,
    required this.addOns,
    required this.price,
  });
}