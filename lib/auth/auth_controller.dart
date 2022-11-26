import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'user_model.dart';

class AuthController extends GetxController {
  static final fauth = FirebaseAuth.instance;
  static final fbase = FirebaseFirestore.instance;
  AppUser? cuser;

  //logincontrol
  Future<bool> logincontrol() async {
    var user = fauth.currentUser;
    if (user == null) {
      return false;
    } else {
      DocumentSnapshot veri =
          await fbase.collection('Users').doc(user.uid).get();
      Map map = veri.data() as Map;
      cuser = AppUser(
          name: map['name'],
          email: map['mail'],
          userid: map['userid'],
          photourl: map['profilphoto'],
          bio: map['bio'],
          meslek: map['meslek'],
          takipci: map['takipci'],
          takipedilen: map['takipedilen'],
          postSayisi: map['postsayisi']);
      return true;
    }
  }

  Future<bool> logout() async {
    await fauth.signOut();
    log('Çıkış Yapıldı');
    return true;
  }

  Future<bool> signupwithpass(String email, String pass) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      var user = credential.user;
      fbase.collection('Users').doc(user!.uid).set({
        'userid': user.uid,
        'name': 'Anonymous',
        'mail': email,
        'profilphoto':
            'https://cdn.webrazzi.com/uploads/2019/01/Yumurta_instagram_hd.png',
        'bio': 'Hello World ',
        'meslek': 'İşsiz',
        'postsayisi': 0,
        'takipci': 0,
        'takipedilen': 0
      });

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        log('Email adresi kullanılıyor');
        Get.snackbar('Hata', 'Email adresi kullanılıyor');
        return false;
      } else {
        log('Hata oluştu');
        Get.snackbar('Hata', 'Hata oluştu');
        return false;
      }
    } catch (e) {
      log('Sunucu kaynaklı hata');
      Get.snackbar('Hata', 'Sunucu kaynaklı hata');
      return false;
    }
  }

  Future<bool> loginwithgoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    try {
      var sonuc = await fauth.signInWithCredential(credential);
      var user = sonuc.user;

      DocumentSnapshot ilkmi =
          await fbase.collection('Users').doc(user!.uid).get();

      if (!ilkmi.exists) {
        fbase.collection('Users').doc(user.uid).set({
          'userid': user.uid,
          'name': user.displayName,
          'mail': user.email,
          'profilphoto': user.photoURL,
          'bio': 'Hello World ',
          'meslek': 'İşsiz',
          'postsayisi': 0,
          'takipci': 0,
          'takipedilen': 0
        });
      }
      logincontrol();
      return true;
    } on FirebaseAuthException {
      log('Google ile girişte hata');
      Get.snackbar('Hata', 'Google ile girişte hata');
      return false;
    } catch (e) {
      log('Google ile girişte sunucu kaynaklı hata');
      log(e.toString());
      Get.snackbar('Hata', 'Google ile girişte sunucu kaynaklı hata');
      return false;
    }
  }

  Future<bool> loginwithpass(String email, String pass) async {
    bool sonuc;
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      log('Giriş Başarılı');
      sonuc = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
        sonuc = false;
        Get.snackbar('Hata', 'Kullanıcı bulunamadı');
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
        Get.snackbar('Hata', 'Kullanıcı şifresi hatalı');
        sonuc = false;
      } else {
        log('Sunucu kaynaklı hata');
        Get.snackbar('Hata', 'Sunucu aynaklı Hata');
        sonuc = false;
      }
    } catch (e) {
      log(e.toString());
      sonuc = false;
    }
    logincontrol();
    return sonuc;
  }
}
