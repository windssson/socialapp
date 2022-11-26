import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meslek_agi/auth/auth_controller.dart';
import 'package:meslek_agi/auth/signin_page.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final authcontroller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: (() {
          authcontroller.logout();
          Get.off(const SigninPage());
        }),
        child: const Text('Çıkış Yap'),
      ),
    );
  }
}
