import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meslek_agi/auth/auth_result.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  final spuabase = Supabase.instance.client;
  final useridkey = '';
  //logincontrol
  Future<bool> logincontrol() async {
    await Future.delayed(const Duration(seconds: 2));
    return false;
  }

  //loginwithgoogle

  Future<AuthResult> signupwithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);

    return AuthResult('', true);
  }

  //loginwithemailpass
  Future<AuthResult> signupemailpass(String email, String pass) async {
    AuthResult sonuc = AuthResult('Sistem kaynaklı sorun.', false);
    await spuabase.auth.signUp(email: email, password: pass).then((value) {
      sonuc = AuthResult('Üye  Kaydınız Başarılı', true);
    }).onError((AuthException error, stackTrace) {
      AuthException hata = error;
      if (hata.statusCode == '400') {
        sonuc = AuthResult('Email adresi kayıtlı', false);
      } else {
        sonuc = AuthResult('Sunucu kaynaklı hata', false);
      }
    });
    return sonuc;
  }
  //createuser

  //loginuser

  //logoutuser

}
