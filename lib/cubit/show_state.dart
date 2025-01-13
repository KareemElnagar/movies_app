part of 'show_cubit.dart';

sealed class ShowState extends Equatable {
  const ShowState();

  @override
  List<Object?> get props => [];
}

final class ShowInitial extends ShowState {}

final class ShowLoading extends ShowState {} // Added loading state

final class ShowLoaded extends ShowState {
  final List<ShowModels> shows;

  const ShowLoaded({required this.shows}); // Made constructor const

  @override
  List<Object?> get props => [shows];
}

final class ShowLoadFailed extends ShowState { // Renamed for consistency
  final String message;

  const ShowLoadFailed({required this.message}); // Made constructor const

  @override
  List<Object?> get props => [message];
}
class ShowSelected extends ShowState {
  late  ShowModels selectedShow;

   ShowSelected({required this.selectedShow});

  @override
  List<Object?> get props => [selectedShow];
}