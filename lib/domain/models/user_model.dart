class UserModel {
  UserModel({
    this.imageUrl,
    required this.email,
    required this.id,
    required this.name,
  });

  final String name;
  final String email;
  final String id;
  final String? imageUrl;
}
