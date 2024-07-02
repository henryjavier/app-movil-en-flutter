// lib/screens/payment_screen.dart
import 'package:flutter/material.dart';
import '../services/fake_payment_service.dart';

class PaymentScreen extends StatefulWidget {
  final double amount;
  final String cinemaName;
  final String showtime;
  final int selectedSeatsCount;

  PaymentScreen({
    required this.amount,
    required this.cinemaName,
    required this.showtime,
    required this.selectedSeatsCount,
  });

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pago'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 4.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Detalles de la Película',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Cinema: ${widget.cinemaName}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Showtime: ${widget.showtime}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Seats: ${widget.selectedSeatsCount}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Total: \$${widget.amount.toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Card(
                  elevation: 4.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Detalles del Pago',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'Nombre del titular',
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese el nombre del titular';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _cardNumberController,
                          decoration: InputDecoration(
                            labelText: 'Número de la tarjeta',
                            prefixIcon: Icon(Icons.credit_card),
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese el número de la tarjeta';
                            }
                            if (value.length != 16) {
                              return 'El número de la tarjeta debe tener 16 dígitos';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _expiryDateController,
                                decoration: InputDecoration(
                                  labelText: 'Fecha de expiración',
                                  prefixIcon: Icon(Icons.date_range),
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.datetime,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor ingrese la fecha de expiración';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                controller: _cvvController,
                                decoration: InputDecoration(
                                  labelText: 'CVV',
                                  prefixIcon: Icon(Icons.lock),
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor ingrese el CVV';
                                  }
                                  if (value.length != 3) {
                                    return 'El CVV debe tener 3 dígitos';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await FakePaymentService().processPayment(widget.amount);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Pago realizado con éxito')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                    child: Text('Pagar \$${widget.amount.toStringAsFixed(2)}'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


