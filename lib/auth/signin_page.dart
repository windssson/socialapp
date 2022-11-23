import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meslek_agi/auth/signup_page.dart';
import 'package:meslek_agi/constant/constant.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  double bosluk = Get.size.height / 50;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  height: bosluk * 5,
                ),
                Text(
                  'Giriş Yap',
                  style: Constant().baslik,
                ),
                SizedBox(
                  height: bosluk * 4,
                ),
                Form(
                    child: Column(
                  children: [
                    SizedBox(
                      height: 48,
                      child: TextFormField(
                        style: Constant().girisinput,
                        textAlignVertical: TextAlignVertical.top,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.green,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: bosluk,
                    ),
                    SizedBox(
                      height: 48,
                      child: TextFormField(
                        style: Constant().girisinput,
                        textAlignVertical: TextAlignVertical.top,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.green,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: bosluk * 3,
                    ),
                    SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Giriş Yap',
                          style: Constant().girisinput,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: bosluk,
                    ),
                    SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Google ile Giriş Yap',
                          style: Constant().girisinput,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: bosluk * 2,
                    ),
                    TextButton(
                        onPressed: (() {
                          Get.to(() => const SignUpPage());
                        }),
                        child: const Text('Hemen Üye Ol'))
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
