class UserProfile {
  final String uid;
  final String name;
  final String email;
  final String phone;
  String? profilePicture;

  UserProfile({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    this.profilePicture,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      profilePicture: json['profile_picture'],
    );
  }
  
}