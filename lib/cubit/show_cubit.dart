import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

import '../models/show_models.dart'; // Import your ShowModels
import '../services/services.dart'; // Import your services
import '../utils/Ticket.dart'; // Import your Ticket class

part 'show_state.dart';

class ShowCubit extends Cubit<ShowState> {
  ShowCubit() : super(ShowInitial(selectedDate: DateTime.now()));

  // Method to load shows
  Future<void> getShows(int page) async {
    emit(ShowLoading(
      selectedSeats: state.selectedSeats,
      ticketCount: state.ticketCount,
      selectedDate: state.selectedDate,
      tickets: state.tickets,
      userName: state.userName,
      userEmail: state.userEmail,
      userProfileImage: state.userProfileImage,
    ));

    ServiceResult<List<ShowModels>> result = await ShowServices.getShow(page);
    print(result.message);

    if (result.data != null) {
      emit(ShowLoaded(
        shows: result.data!,
        selectedSeats: state.selectedSeats,
        ticketCount: state.ticketCount,
        selectedDate: state.selectedDate,
        tickets: state.tickets,
        userName: state.userName,
        userEmail: state.userEmail,
        userProfileImage: state.userProfileImage,
      ));
    } else {
      emit(ShowLoadFailed(
        message: result.message!,
        selectedSeats: state.selectedSeats,
        ticketCount: state.ticketCount,
        selectedDate: state.selectedDate,
        tickets: state.tickets,
        userName: state.userName,
        userEmail: state.userEmail,
        userProfileImage: state.userProfileImage,
      ));
    }
  }

  // Method to update selected date
  void updateSelectedDate(DateTime date) {
    final currentState = state;
    if (currentState is ShowLoaded) {
      emit(currentState.copyWith(selectedDate: date));
    } else if (currentState is ShowInitial) {
      emit(currentState.copyWith(selectedDate: date));
    }
  }

  // Method to toggle seat selection
  void toggleSeatSelection(int seatId) {
    final currentState = state;
    if (currentState is ShowLoaded) {
      final selectedSeats = List<int>.from(currentState.selectedSeats);
      if (selectedSeats.contains(seatId)) {
        selectedSeats.remove(seatId);
      } else {
        selectedSeats.add(seatId);
      }
      emit(currentState.copyWith(selectedSeats: selectedSeats));
    }
  }

  // Method to update ticket count
  void updateTicketCount(int count) {
    final currentState = state;
    if (currentState is ShowLoaded) {
      emit(currentState.copyWith(ticketCount: count));
    }
  }

  // Method to reset selections
  void resetSelection() {
    final currentState = state;
    if (currentState is ShowLoaded) {
      emit(currentState.copyWith(selectedSeats: [], ticketCount: 0));
    }
  }

  // Method to add a ticket
  void addTicket(Ticket ticket) {
    final currentState = state;
    if (currentState is ShowLoaded) {
      final tickets = List<Ticket>.from(currentState.tickets)..add(ticket);
      emit(currentState.copyWith(tickets: tickets));
    }
  }

  // Method to get all tickets
  List<Ticket> get tickets {
    final currentState = state;
    if (currentState is ShowLoaded) {
      return currentState.tickets;
    }
    return [];
  }

  // Method to update user profile data (no longer tied to SharedPreferences)
  void updateUserProfile({
    String? userName,
    String? userEmail,
    File? userProfileImage,
  }) {
    final currentState = state;
    if (currentState is ShowLoaded) {
      emit(currentState.copyWith(
        userName: userName ?? currentState.userName,
        userEmail: userEmail ?? currentState.userEmail,
        userProfileImage: userProfileImage ?? currentState.userProfileImage,
      ));
    } else if (currentState is ShowInitial) {
      emit(currentState.copyWith(
        userName: userName ?? currentState.userName,
        userEmail: userEmail ?? currentState.userEmail,
        userProfileImage: userProfileImage ?? currentState.userProfileImage,
      ));
    }
  }
}