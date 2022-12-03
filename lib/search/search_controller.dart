import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:meslek_agi/auth/auth_controller.dart';
import 'package:meslek_agi/auth/user_model.dart';

class SearchController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final auth = Get.put(AuthController());

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
    AppUser my = auth.cuser!;
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
        .doc(userid)
        .collection('takipeden')
        .doc(myuid)
        .set({
      'username': my.name,
      'meslek': my.meslek,
      'userid': my.userid,
      'photourl': my.photourl
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

    await _firestore
        .collection('Users')
        .doc(userid)
        .collection('takipeden')
        .doc(myuid)
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
