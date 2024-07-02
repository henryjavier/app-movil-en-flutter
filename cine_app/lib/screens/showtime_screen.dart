import 'package:flutter/material.dart';
import '../models/showtime.dart';
import '../services/showtime_service.dart';
import 'seat_selection_screen.dart';

class ShowtimeScreen extends StatefulWidget {
  final int movieId;

  ShowtimeScreen({required this.movieId});

  @override
  _ShowtimeScreenState createState() => _ShowtimeScreenState();
}

class _ShowtimeScreenState extends State<ShowtimeScreen> {
  late Future<List<Showtime>> futureShowtimes;

  @override
  void initState() {
    super.initState();
    futureShowtimes = ShowtimeService().fetchShowtimes(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Horarios de la Película'),
      ),
      body: FutureBuilder<List<Showtime>>(
        future: futureShowtimes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Showtime showtime = snapshot.data![index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          showtime.cinemaName,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          showtime.date,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 10),
                        Wrap(
                          spacing: 10,
                          children: showtime.times.map((time) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                textStyle: TextStyle(fontSize: 14),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SeatSelectionScreen(
                                      cinemaName: showtime.cinemaName,
                                      showtime: time,
                                    ),
                                  ),
                                );
                              },
                              child: Text(time),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

