part of 'services.dart';

class ShowServices implements Services {
  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void init() {
    // TODO: implement init
  }

  static Future<ServiceResult<List<ShowModels>>> getShow(int page,
      { http.Client? client}) async {
    client = http.Client();
    try {
      String url = 'https://www.episodate.com/api/most-popular?page=$page';

      var response = await client.get(
          Uri.parse(url), headers: {"Accept": "application/json"});

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        List<ShowModels> showModels = (data['tv_shows'] as Iterable).map((
            e) =>
            ShowModels.fromJson(e)).toList();

        return ServiceResult(data: showModels);
      } else {
        return ServiceResult(
            message: "Status Code ${response.statusCode}",
            status: false);
      }
    }
    catch (e) {
      return ServiceResult(message: e.toString(), status: false);
    }
  }


  static Future<ShowDetailsModels?> getShowDetails(ShowModels showModels,
      { http.Client? client}) async {
    client = http.Client();
    try {
      String url = 'https://www.episodate.com/api/show-details?q=${showModels
          .id}';

      var response = await client.get(
          Uri.parse(url), headers: {"Accept": "application/json"});

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        final result = data['tvShow'];

        return ShowDetailsModels(
          ShowModels.fromJson(result), bigImage: result['image_path'],
          description: result['description'],
          genres: result['genres'],
          rating: result['rating'],

        );
      }
      else {
        print(response.statusCode);
        throw Exception('Failed to load show details');
      }
    }
    catch (e) {
      print(e);
    }
  }
}