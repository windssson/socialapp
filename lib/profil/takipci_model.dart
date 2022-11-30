
class TakipciModel {
  String name;
  String photo;
  String userid;
  String meslek;

  TakipciModel(
      {required this.name,
      required this.photo,
      required this.userid,
      required this.meslek});

  Map<String, dynamic> toMap() {
    return {'username': name, 'photourl': photo, 'userid': userid, 'meslek': meslek};
  }

  factory TakipciModel.fromjson(Map<String, dynamic> json) {
    return TakipciModel(
        name: json['username'],
        photo: json['photourl'],
        userid: json['userid'],
        meslek: json['meslek']);
  }
}
