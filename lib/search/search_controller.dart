import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> takipcontrol(String myuid, String uid) async {
    DocumentSnapshot sonuc = await _firestore
        .collection('Users')
        .doc(myuid)
        .collection('takipler')
        .doc(uid)
        .get();
    log(sonuc.data().toString());
    if (sonuc.exists) {
      log('Takip ediliyor');
      return false;
    } else {
      log('Takip edilmiyor');
      return true;
    }
  }

  Future<bool> takipEt(String myuid, String userid, String meslek, String name,
      String photourl) async {
    await _firestore
        .collection('Users')
        .doc(myuid)
        .collection('takipler')
        .doc(userid)
        .set({
      'username': name,
      'meslek': meslek,
      'userid': userid,
      'photourl': photourl
    });
    await _firestore
        .collection('Users')
        .doc(myuid)
        .set({'takipedilen': FieldValue.increment(1)}, SetOptions(merge: true));
    await _firestore
        .collection('Users')
        .doc(userid)
        .set({'takipci': FieldValue.increment(1)}, SetOptions(merge: true));
    return true;
  }

  Future<bool> takipBirak(String myuid, String userid) async {
    await _firestore
        .collection('Users')
        .doc(myuid)
        .collection('takipler')
        .doc(userid)
        .delete();
    await _firestore.collection('Users').doc(myuid).set(
        {'takipedilen': FieldValue.increment(-1)}, SetOptions(merge: true));
    await _firestore
        .collection('Users')
        .doc(userid)
        .set({'takipci': FieldValue.increment(-1)}, SetOptions(merge: true));
    return true;
  }
}
