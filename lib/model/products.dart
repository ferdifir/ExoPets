class Products {
  final int id;
  String? image;
  String? name;
  String? category;
  int price;
  int? isApproved;
  String? createdAt;

  Products({
    required this.id,
    required this.image,
    required this.name,
    required this.category,
    required this.price,
    this.isApproved,
    this.createdAt,
  });

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      id: json['pid'],
      image: json['image'],
      name: json['product_name'],
      category: json['category'],
      price: json['price'],
      isApproved: json['is_approved'],
      createdAt: json['created_at'],
    );
  }
}