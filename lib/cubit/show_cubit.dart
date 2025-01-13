import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/models/show_details_model.dart';

import '../models/show_models.dart';
import '../services/services.dart';

part 'show_state.dart';

class ShowCubit extends Cubit<ShowState> {
  ShowCubit() : super(ShowInitial());

  void selectShow(ShowModels show) {
    emit(ShowSelected(selectedShow: show));
  }

  final List<ShowModels> movies = [];

  Future<void> getShows(int page) async {
    ServiceResult<List<ShowModels>> result = await ShowServices.getShow(page);
    print(result.message);
    if (result.data != null){
      emit(ShowLoaded(shows: result.data!));
    } else{
      emit(ShowLoadFailed(message: result.message!));
    }
  }
}
