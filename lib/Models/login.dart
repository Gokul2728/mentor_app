class LoginModule {
  final String id;
  final String name;
  final String profileImg;
  final String email;
  final String role;

  LoginModule({
    required this.id,
    required this.name,
    required this.profileImg,
    required this.email,
    required this.role,
  });

  factory LoginModule.fromJson(Map<String, dynamic> json) {
    return LoginModule(
      id: json['id'] as String,
      name: json['name'] as String,
      profileImg: json['profile_img'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'profile_img': profileImg,
      'email': email,
      'role': role,
    };
  }
}
