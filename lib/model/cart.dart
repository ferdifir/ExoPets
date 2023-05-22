class Cart {
  final int id;
  final String image;
  final String title;
  final int price;

  Cart({
    required this.id,
    required this.image,
    required this.title,
    required this.price,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['product_id'],
      image: json['image'],
      title: json['product_name'],
      price: json['price'],
    );
  }
}