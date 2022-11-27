import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  int begeni;
  String gonderiid;
  String icerik;
  String name;
  String photo;
  String userid;
  DateTime zaman;

  PostModel(
      {required this.begeni,
      required this.gonderiid,
      required this.icerik,
      required this.name,
      required this.photo,
      required this.userid,
      required this.zaman});

  Map<String, dynamic> toMap() {
    return {
      'begeni': begeni,
      'gonderiid': gonderiid,
      'icerik': icerik,
      'name': name,
      'photo': photo,
      'userid': userid,
      'zaman': zaman
    };
  }

  factory PostModel.fromjson(Map<String, dynamic> json) {
    return PostModel(
        begeni: json['begeni'],
        gonderiid: json['gonderiid'],
        icerik: json['icerik'],
        name: json['name'],
        photo: json['photo'],
        userid: json['userid'],
        zaman: (json['zaman'] as Timestamp).toDate());
  }
}
