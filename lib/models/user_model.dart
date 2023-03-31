

class User {
  final int id;
  final String name;
  final String imageUrl;

  const User({
    required this.id,
    required this.name,
    this.imageUrl = "",
  });
}
