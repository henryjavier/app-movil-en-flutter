// lib/services/movie_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/movie.dart';

class MovieService {
  final String apiKey = '1337f3f29ef32f761be6dbdaaf8b8598';
  final String apiUrl = 'https://api.themoviedb.org/3/movie/now_playing?api_key=';

  Future<List<Movie>> fetchMovies() async {
    final response = await http.get(Uri.parse('$apiUrl$apiKey'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['results'];
      return data.map((item) => Movie(
        title: item['title'],
        posterUrl: 'https://image.tmdb.org/t/p/w500${item['poster_path']}',
        synopsis: item['overview'],
      )).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
