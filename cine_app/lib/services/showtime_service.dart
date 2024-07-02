// lib/services/showtime_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/showtime.dart';

class ShowtimeService {
  final String apiUrl = 'https://cine-93fda-default-rtdb.firebaseio.com/movies.json';

  Future<List<Showtime>> fetchShowtimes(int movieId) async {
    final response = await http.get(Uri.parse('$apiUrl?movie_id=$movieId'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Showtime(
        cinemaName: item['cinema_name'],
        date: item['date'],
        times: List<String>.from(item['times']),
      )).toList();
    } else {
      throw Exception('Failed to load showtimes');
    }
  }
}
