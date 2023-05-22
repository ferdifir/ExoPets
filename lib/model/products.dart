class Products {
  final int id;
  final String image;
  final String name;
  final String category;
  final int price;

  Products({
    required this.id,
    required this.image,
    required this.name,
    required this.category,
    required this.price,
  });

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      id: json['pid'],
      image: json['image'],
      name: json['product_name'],
      category: json['category'],
      price: json['price'],
    );
  }
}