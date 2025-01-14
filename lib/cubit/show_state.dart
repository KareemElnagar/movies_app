part of 'show_cubit.dart';

sealed class ShowState extends Equatable {
  final List<int> selectedSeats;
  final int ticketCount;
  final DateTime selectedDate;
  final List<Ticket> tickets; // Add tickets property

  const ShowState({
    this.selectedSeats = const [],
    this.ticketCount = 0,
    required this.selectedDate,
    this.tickets = const [], // Initialize tickets
  });

  @override
  List<Object?> get props => [selectedSeats, ticketCount, selectedDate, tickets];
}

final class ShowInitial extends ShowState {
  const ShowInitial({
    List<int> selectedSeats = const [],
    int ticketCount = 0,
    required DateTime selectedDate,
    List<Ticket> tickets = const [],
  }) : super(
    selectedSeats: selectedSeats,
    ticketCount: ticketCount,
    selectedDate: selectedDate,
    tickets: tickets,
  );

  ShowInitial copyWith({
    List<int>? selectedSeats,
    int? ticketCount,
    DateTime? selectedDate,
    List<Ticket>? tickets,
  }) {
    return ShowInitial(
      selectedSeats: selectedSeats ?? this.selectedSeats,
      ticketCount: ticketCount ?? this.ticketCount,
      selectedDate: selectedDate ?? this.selectedDate,
      tickets: tickets ?? this.tickets,
    );
  }
}

final class ShowLoading extends ShowState {
  const ShowLoading({
    List<int> selectedSeats = const [],
    int ticketCount = 0,
    required DateTime selectedDate,
    List<Ticket> tickets = const [],
  }) : super(
    selectedSeats: selectedSeats,
    ticketCount: ticketCount,
    selectedDate: selectedDate,
    tickets: tickets,
  );

  ShowLoading copyWith({
    List<int>? selectedSeats,
    int? ticketCount,
    DateTime? selectedDate,
    List<Ticket>? tickets,
  }) {
    return ShowLoading(
      selectedSeats: selectedSeats ?? this.selectedSeats,
      ticketCount: ticketCount ?? this.ticketCount,
      selectedDate: selectedDate ?? this.selectedDate,
      tickets: tickets ?? this.tickets,
    );
  }
}

final class ShowLoaded extends ShowState {
  final List<ShowModels> shows;

  const ShowLoaded({
    required this.shows,
    List<int> selectedSeats = const [],
    int ticketCount = 0,
    required DateTime selectedDate,
    List<Ticket> tickets = const [],
  }) : super(
    selectedSeats: selectedSeats,
    ticketCount: ticketCount,
    selectedDate: selectedDate,
    tickets: tickets,
  );

  @override
  List<Object?> get props => [shows, ...super.props];

  ShowLoaded copyWith({
    List<ShowModels>? shows,
    List<int>? selectedSeats,
    int? ticketCount,
    DateTime? selectedDate,
    List<Ticket>? tickets,
  }) {
    return ShowLoaded(
      shows: shows ?? this.shows,
      selectedSeats: selectedSeats ?? this.selectedSeats,
      ticketCount: ticketCount ?? this.ticketCount,
      selectedDate: selectedDate ?? this.selectedDate,
      tickets: tickets ?? this.tickets,
    );
  }
}

final class ShowLoadFailed extends ShowState {
  final String message;

  const ShowLoadFailed({
    required this.message,
    List<int> selectedSeats = const [],
    int ticketCount = 0,
    required DateTime selectedDate,
    List<Ticket> tickets = const [],
  }) : super(
    selectedSeats: selectedSeats,
    ticketCount: ticketCount,
    selectedDate: selectedDate,
    tickets: tickets,
  );

  @override
  List<Object?> get props => [message, ...super.props];

  ShowLoadFailed copyWith({
    String? message,
    List<int>? selectedSeats,
    int? ticketCount,
    DateTime? selectedDate,
    List<Ticket>? tickets,
  }) {
    return ShowLoadFailed(
      message: message ?? this.message,
      selectedSeats: selectedSeats ?? this.selectedSeats,
      ticketCount: ticketCount ?? this.ticketCount,
      selectedDate: selectedDate ?? this.selectedDate,
      tickets: tickets ?? this.tickets,
    );
  }
}