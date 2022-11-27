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

  factory AppUser.tomap(Map<String, dynamic> json) => AppUser(
      name: json['name'],
      email: json['mail'],
      userid: json['userid'],
      photourl: json['profilphoto'],
      bio: json['bio'],
      meslek: json['meslek'],
      takipci: json['takipci'],
      takipedilen: json['takipedilen'],
      postSayisi: json['postsayisi']);
}
