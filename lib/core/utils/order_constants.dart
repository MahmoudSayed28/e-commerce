class PaymentMethods {
  static const String cash = 'cash';
  static const String card = 'card';
}

class PaymentStatuses {
  static const String pending = 'pending';
  static const String awaitingPayment = 'awaiting_payment';
  static const String paid = 'paid';
  static const String failed = 'failed';
  static const String refunded = 'refunded';
}

class OrderStatuses {
  static const String pending = 'pending';
  static const String awaitingPayment = 'awaiting_payment';
  static const String confirmed = 'confirmed';
  static const String paymentFailed = 'payment_failed';
  static const String cancelled = 'cancelled';
}