import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meslek_agi/auth/auth_controller.dart';

class Denemepage extends StatefulWidget {
  const Denemepage({super.key});

  @override
  State<Denemepage> createState() => _DenemepageState();
}

class _DenemepageState extends State<Denemepage> {
  var usercontroller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            
          },
          child: Text('Veri Getir'),
        ),
      ),
    );
  }
}
