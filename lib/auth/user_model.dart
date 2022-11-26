class AppUser {
  String userid;
  String name;
  String email;
  String photourl;
  String bio;
  String meslek;
  int takipci;
  int takipedilen;
  int postSayisi;

  AppUser(
      {required this.name,
      required this.email,
      required this.userid,
      required this.photourl,
      required this.bio,
      required this.meslek,
      required this.takipci,
      required this.takipedilen,
      required this.postSayisi});
  @override
  String toString() {
    return '$name - $email';
  }
}
