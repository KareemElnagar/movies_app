import 'package:equatable/equatable.dart';

class ShowModels extends Equatable {
  final String name;
  final int id;
  final String permalink;
  final String startDate;
  final String? endDate;
  final String country;
  final String network;
  final String status;
  final String image;

  const ShowModels({
    required this.name,
    required this.id,
    required this.permalink,
    required this.startDate,
     this.endDate,
    required this.country,
    required this.network,
    required this.status,
    required this.image,
  });

  factory ShowModels.fromJson(Map<String, dynamic> map) => ShowModels(
        name: map['name'],
        id: map['id'] as int,
        permalink: map['permalink'],
        startDate: map['start_date'],
        endDate: map['end_date'],
        country: map['country'],
        network: map['network'],
        status: map['status'],
        image: map['image_thumbnail_path'],
      );

  @override
  List<Object?> get props => [
        name,
        id,
        permalink,
        startDate,
        endDate,
        country,
        network,
        status,
        image
      ];
}
