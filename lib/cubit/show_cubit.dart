import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import '../models/show_models.dart'; // Import your ShowModels
import '../services/services.dart'; // Import your services
import '../utils/Ticket.dart'; // Import your Ticket class

part 'show_state.dart';

class ShowCubit extends Cubit<ShowState> {
  ShowCubit() : super(ShowInitial(selectedDate: DateTime.now())) {
    _loadProfileData(); // Load profile data when the Cubit is created
  }

  // Method to load profile data from SharedPreferences
  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    final userName = prefs.getString('userName') ?? 'John Doe';
    final userEmail = prefs.getString('userEmail') ?? 'johndoe@example.com';
    final userProfileImagePath = prefs.getString('userProfileImagePath');

    File? userProfileImage;
    if (userProfileImagePath != null) {
      userProfileImage = File(userProfileImagePath);
    }

    final currentState = state;
    if (currentState is ShowLoaded) {
      emit(currentState.copyWith(
        userName: userName,
        userEmail: userEmail,
        userProfileImage: userProfileImage,
      ));
    } else if (currentState is ShowInitial) {
      emit(currentState.copyWith(
        userName: userName,
        userEmail: userEmail,
        userProfileImage: userProfileImage,
      ));
    }
    print('Profile data loaded from SharedPreferences'); // Debug log
  }

  // Method to save profile data to SharedPreferences
  Future<void> _saveProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', state.userName);
    await prefs.setString('userEmail', state.userEmail);
    if (state.userProfileImage != null) {
      await prefs.setString('userProfileImagePath', state.userProfileImage!.path);
    } else {
      await prefs.remove('userProfileImagePath');
    }
    print('Profile data saved to SharedPreferences'); // Debug log
  }

  // Method to update the user's name
  void updateUserName(String newName) {
    final currentState = state;
    if (currentState is ShowLoaded) {
      emit(currentState.copyWith(userName: newName));
    } else if (currentState is ShowInitial) {
      emit(currentState.copyWith(userName: newName));
    }
    _saveProfileData(); // Save the updated name
  }

  void updateUserEmail(String newEmail) {
    final currentState = state;
    if (currentState is ShowLoaded) {
      emit(currentState.copyWith(userEmail: newEmail));
    } else if (currentState is ShowInitial) {
      emit(currentState.copyWith(userEmail: newEmail));
    }
    _saveProfileData(); // Save the updated email
  }

  void updateUserProfileImage(File newImage) {
    final currentState = state;
    if (currentState is ShowLoaded) {
      emit(currentState.copyWith(userProfileImage: newImage));
    } else if (currentState is ShowInitial) {
      emit(currentState.copyWith(userProfileImage: newImage));
    }
    _saveProfileData(); // Save the updated profile image
  }

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
}