class User {
  String name;
  String email;

  User({required this.name, required this.email});
  @override
  String toString() {
    return '$name - $email';
  }
}
