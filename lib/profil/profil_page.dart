import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meslek_agi/auth/auth_controller.dart';
import 'package:meslek_agi/auth/signin_page.dart';
import 'package:meslek_agi/auth/signup_page.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  final authcontroller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: ElevatedButton(
              onPressed: (() async {
                await authcontroller.logout();
                Get.off(SigninPage());
              }),
              child: Text('Çıkış Yap'))),
    );
  }
}
