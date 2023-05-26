class Transaction {
  final String id;
  final int productId;
  final DateTime date;
  final int total;
  final int quantity;
  final String status;
  final String paymentMethod;
  
  Transaction({
    required this.id,
    required this.date,
    required this.total,
    required this.quantity,
    required this.status,
    required this.paymentMethod,
    required this.productId,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['tid'],
      date: DateTime.parse(json['transaction_date']),
      total: json['total_amount'],
      quantity: json['quantity'],
      status: json['status'],
      paymentMethod: json['payment_method'],
      productId: json['pid'],
    );
  }
}
