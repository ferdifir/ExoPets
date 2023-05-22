class Address {
  int? id;
  String? address;
  String? name;
  String? phone;
  String? city;
  String? province;
  String? postalCode;

  Address({
    required this.id,
    this.address,
    this.name,
    this.phone,
    this.city,
    this.province,
    this.postalCode,
  });

  Address.fromJson(Map<String, dynamic> json) {
    id = json['address_id'];
    address = json['street_address'];
    name = json['name'];
    phone = json['phone'];
    city = json['city'];
    province = json['province'];
    postalCode = json['postal_code'];
  }

}