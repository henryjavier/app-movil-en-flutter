// lib/screens/seat_selection_screen.dart
import 'package:flutter/material.dart';
import 'payment_screen.dart';

class SeatSelectionScreen extends StatefulWidget {
  final String cinemaName;
  final String showtime;

  SeatSelectionScreen({required this.cinemaName, required this.showtime});

  @override
  _SeatSelectionScreenState createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  late List<List<bool>> seats;
  double ticketPrice = 15.0; // Precio fijo por boleto
  int selectedSeatsCount = 0;

  @override
  void initState() {
    super.initState();
    seats = List.generate(10, (i) => List.generate(10, (j) => true)); // true indica que el asiento está disponible
  }

  void toggleSeatSelection(int row, int col) {
    setState(() {
      seats[row][col] = !seats[row][col];
      selectedSeatsCount += seats[row][col] ? -1 : 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalAmount = selectedSeatsCount * ticketPrice;

    return Scaffold(
      appBar: AppBar(
        title: Text('Selecciona tus asientos'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '${widget.cinemaName} - ${widget.showtime}',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 10,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
              ),
              itemCount: 70,
              itemBuilder: (context, index) {
                int row = index ~/ 10;
                int col = index % 10;
                return GestureDetector(
                  onTap: () => toggleSeatSelection(row, col),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.event_seat,
                        color: seats[row][col] ? Colors.green : Colors.red,
                        size: 50,
                      ),
                      Text(
                        '${row + 1}${String.fromCharCode(65 + col)}',
                        style: TextStyle(
                          color: seats[row][col] ? Colors.black : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total: S/${totalAmount.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
            onPressed: selectedSeatsCount > 0 ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentScreen(
                    amount: totalAmount,
                    cinemaName: widget.cinemaName,
                    showtime: widget.showtime,
                    selectedSeatsCount: selectedSeatsCount,
                  ),
                ),
              );
            } : null,
            child: Text('Comprar Boletos'),
          ),
        ],
      ),
    );
  }
}

