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

  // Convert Ticket to a Map (for JSON serialization)
  Map<String, dynamic> toJson() {
    return {
      'movieTitle': movieTitle,
      'date': date,
      'time': time,
      'row': row,
      'seats': seats,
      'addOns': addOns,
      'price': price,
    };
  }

  // Create a Ticket from a Map (for JSON deserialization)
  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      movieTitle: json['movieTitle'],
      date: json['date'],
      time: json['time'],
      row: json['row'],
      seats: List<int>.from(json['seats']),
      addOns: Map<String, double>.from(json['addOns']),
      price: json['price'],
    );
  }
}