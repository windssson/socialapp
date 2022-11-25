class AppUser {
  final userid;
  String name;
  String email;
  String photourl;

  AppUser({required this.name, required this.email,required this.userid,required this.photourl});
  @override
  String toString() {
    return '$name - $email';
  }
}
