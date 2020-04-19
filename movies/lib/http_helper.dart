import 'dart:convert';
import 'dart:io';
import 'movie.dart';
import 'package:http/http.dart' as http;

class HttpHelper {
  final String urlKey = 'api_key=c70c7331bfa933b3c2f8d7bb3735bdeb';
  final String urlBase = 'https://api.themoviedb.org/3/movie/';
  final String urlUpcoming = 'upcoming?';
  final String urlLanguage = '&language=en-US';

  Future<List> getUpcoming() async {
    final String upcoming = urlBase + urlUpcoming + urlKey + urlLanguage;

    http.Response result = await http.get(upcoming);

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['results'];
      List movies = moviesMap.map((movie) => Movie.fromJson(movie)).toList();
      return movies;
    } else {
      return null;
    }
  }
}
