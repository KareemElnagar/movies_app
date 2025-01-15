part of 'show_cubit.dart';

sealed class ShowState extends Equatable {
  final List<int> selectedSeats;
  final int ticketCount;
  final DateTime selectedDate;
  final List<Ticket> tickets;
  final String userName; // User name (no longer tied to SharedPreferences)
  final String userEmail; // User email (no longer tied to SharedPreferences)
  final File? userProfileImage; // User profile image (no longer tied to SharedPreferences)

  const ShowState({
    this.selectedSeats = const [],
    this.ticketCount = 0,
    required this.selectedDate,
    this.tickets = const [],
    this.userName = 'John Doe', // Default name
    this.userEmail = 'johndoe@example.com', // Default email
    this.userProfileImage, // Optional profile image
  });

  @override
  List<Object?> get props => [
    selectedSeats,
    ticketCount,
    selectedDate,
    tickets,
    userName,
    userEmail,
    userProfileImage,
  ];
}

final class ShowInitial extends ShowState {
  const ShowInitial({
    List<int> selectedSeats = const [],
    int ticketCount = 0,
    required DateTime selectedDate,
    List<Ticket> tickets = const [],
    String userName = 'John Doe',
    String userEmail = 'johndoe@example.com',
    File? userProfileImage,
  }) : super(
    selectedSeats: selectedSeats,
    ticketCount: ticketCount,
    selectedDate: selectedDate,
    tickets: tickets,
    userName: userName,
    userEmail: userEmail,
    userProfileImage: userProfileImage,
  );

  ShowInitial copyWith({
    List<int>? selectedSeats,
    int? ticketCount,
    DateTime? selectedDate,
    List<Ticket>? tickets,
    String? userName,
    String? userEmail,
    File? userProfileImage,
  }) {
    return ShowInitial(
      selectedSeats: selectedSeats ?? this.selectedSeats,
      ticketCount: ticketCount ?? this.ticketCount,
      selectedDate: selectedDate ?? this.selectedDate,
      tickets: tickets ?? this.tickets,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      userProfileImage: userProfileImage ?? this.userProfileImage,
    );
  }
}

final class ShowLoading extends ShowState {
  const ShowLoading({
    List<int> selectedSeats = const [],
    int ticketCount = 0,
    required DateTime selectedDate,
    List<Ticket> tickets = const [],
    String userName = 'John Doe',
    String userEmail = 'johndoe@example.com',
    File? userProfileImage,
  }) : super(
    selectedSeats: selectedSeats,
    ticketCount: ticketCount,
    selectedDate: selectedDate,
    tickets: tickets,
    userName: userName,
    userEmail: userEmail,
    userProfileImage: userProfileImage,
  );

  ShowLoading copyWith({
    List<int>? selectedSeats,
    int? ticketCount,
    DateTime? selectedDate,
    List<Ticket>? tickets,
    String? userName,
    String? userEmail,
    File? userProfileImage,
  }) {
    return ShowLoading(
      selectedSeats: selectedSeats ?? this.selectedSeats,
      ticketCount: ticketCount ?? this.ticketCount,
      selectedDate: selectedDate ?? this.selectedDate,
      tickets: tickets ?? this.tickets,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      userProfileImage: userProfileImage ?? this.userProfileImage,
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
    String userName = 'John Doe',
    String userEmail = 'johndoe@example.com',
    File? userProfileImage,
  }) : super(
    selectedSeats: selectedSeats,
    ticketCount: ticketCount,
    selectedDate: selectedDate,
    tickets: tickets,
    userName: userName,
    userEmail: userEmail,
    userProfileImage: userProfileImage,
  );

  @override
  List<Object?> get props => [shows, ...super.props];

  ShowLoaded copyWith({
    List<ShowModels>? shows,
    List<int>? selectedSeats,
    int? ticketCount,
    DateTime? selectedDate,
    List<Ticket>? tickets,
    String? userName,
    String? userEmail,
    File? userProfileImage,
  }) {
    return ShowLoaded(
      shows: shows ?? this.shows,
      selectedSeats: selectedSeats ?? this.selectedSeats,
      ticketCount: ticketCount ?? this.ticketCount,
      selectedDate: selectedDate ?? this.selectedDate,
      tickets: tickets ?? this.tickets,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      userProfileImage: userProfileImage ?? this.userProfileImage,
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
    String userName = 'John Doe',
    String userEmail = 'johndoe@example.com',
    File? userProfileImage,
  }) : super(
    selectedSeats: selectedSeats,
    ticketCount: ticketCount,
    selectedDate: selectedDate,
    tickets: tickets,
    userName: userName,
    userEmail: userEmail,
    userProfileImage: userProfileImage,
  );

  @override
  List<Object?> get props => [message, ...super.props];

  ShowLoadFailed copyWith({
    String? message,
    List<int>? selectedSeats,
    int? ticketCount,
    DateTime? selectedDate,
    List<Ticket>? tickets,
    String? userName,
    String? userEmail,
    File? userProfileImage,
  }) {
    return ShowLoadFailed(
      message: message ?? this.message,
      selectedSeats: selectedSeats ?? this.selectedSeats,
      ticketCount: ticketCount ?? this.ticketCount,
      selectedDate: selectedDate ?? this.selectedDate,
      tickets: tickets ?? this.tickets,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      userProfileImage: userProfileImage ?? this.userProfileImage,
    );
  }
}