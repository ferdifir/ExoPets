class Payment {
  Payment({
    required this.paymentId,
    required this.transactionId,
    required this.senderName,
    required this.bankTransferInfo,
    required this.tid,
    required this.userId,
    required this.productId,
    required this.transactionDate,
    required this.quantity,
    required this.totalAmount,
    required this.status,
    required this.paymentMethod,
    required this.shippingAddressId,
    required this.pid,
    required this.image,
    required this.productName,
    required this.category,
    required this.age,
    required this.health,
    required this.sex,
    required this.price,
    required this.details,
    required this.storeId,
    required this.isApproved,
    required this.createdAt,
    required this.uid,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.address,
    required this.profilePicture,
  });

  final int? paymentId;
  final int? transactionId;
  final String? senderName;
  final String? bankTransferInfo;
  final String? tid;
  final String? userId;
  final int? productId;
  final DateTime? transactionDate;
  final int? quantity;
  final int? totalAmount;
  final String? status;
  final String? paymentMethod;
  final int? shippingAddressId;
  final int? pid;
  final String? image;
  final String? productName;
  final String? category;
  final int? age;
  final String? health;
  final String? sex;
  final int? price;
  final String? details;
  final int? storeId;
  final int? isApproved;
  final DateTime? createdAt;
  final String? uid;
  final String? name;
  final String? email;
  final String? password;
  final String? phone;
  final Address? address;
  final String? profilePicture;

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      paymentId: json["payment_id"],
      transactionId: json["transaction_id"],
      senderName: json["sender_name"],
      bankTransferInfo: json["bank_transfer_info"],
      tid: json["tid"],
      userId: json["user_id"],
      productId: json["product_id"],
      transactionDate: DateTime.tryParse(json["transaction_date"] ?? ""),
      quantity: json["quantity"],
      totalAmount: json["total_amount"],
      status: json["status"],
      paymentMethod: json["payment_method"],
      shippingAddressId: json["shipping_address_id"],
      pid: json["pid"],
      image: json["image"],
      productName: json["product_name"],
      category: json["category"],
      age: json["age"],
      health: json["health"],
      sex: json["sex"],
      price: json["price"],
      details: json["details"],
      storeId: json["store_id"],
      isApproved: json["is_approved"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      uid: json["uid"],
      name: json["name"],
      email: json["email"],
      password: json["password"],
      phone: json["phone"],
      address:
          json["address"] == null ? null : Address.fromJson(json["address"]),
      profilePicture: json["profile_picture"],
    );
  }
}

class Address {
  Address({
    required this.x,
    required this.y,
  });

  final double? x;
  final double? y;

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      x: json["x"],
      y: json["y"],
    );
  }
}
