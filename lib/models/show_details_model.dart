import 'package:equatable/equatable.dart';

import 'show_models.dart';

class ShowDetailsModels extends ShowModels {
  final List genres;
  final String bigImage;
  final String rating;
  final String description;

   ShowDetailsModels(
    ShowModels showModels, {
    required this.genres,
    required this.bigImage,
    required this.rating,
    required this.description,
  }) : super (
     country: showModels.country,
     endDate: showModels.endDate,
     id: showModels.id,
     image: showModels.image,
     name: showModels.name,
     network: showModels.network,
     permalink: showModels.permalink,
     startDate: showModels.startDate,
     status: showModels.status
   );

  @override
  List<Object?> get props => [genres, bigImage, rating, description];
}
