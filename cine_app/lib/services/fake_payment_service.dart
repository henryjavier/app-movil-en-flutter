// lib/services/fake_payment_service.dart
class FakePaymentService {
  Future<void> processPayment(double amount) async {
    // Simulación de procesamiento de pago
    print('Processing payment of S/${amount.toStringAsFixed(2)}');
    await Future.delayed(Duration(seconds: 2));
    print('Payment successful');
  }
}
