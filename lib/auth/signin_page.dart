import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meslek_agi/auth/auth_controller.dart';
import 'package:meslek_agi/auth/signup_page.dart';
import 'package:meslek_agi/constant/constant.dart';

import '../feed_page.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final authcontroller = Get.put(AuthController());
  double bosluk = Get.size.height / 50;
  String _email = '', _password = '';
  final _formkey = GlobalKey<FormState>();

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
                  key: _formkey,
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
                          validator: (value) {
                            if (!EmailValidator.validate(value!)) {
                              return 'Email adresini giriniz';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (newValue) {
                            _email = newValue!;
                          },
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
                          validator: (value) {
                            if (value!.length <= 8) {
                              return 'Şifre en az 8 karakter';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (newValue) {
                            _password = newValue!;
                          },
                        ),
                      ),
                      SizedBox(
                        height: bosluk * 3,
                      ),
                      SizedBox(
                        height: 45,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            bool formkontrol =
                                _formkey.currentState!.validate();
                            if (formkontrol) {
                              _formkey.currentState!.save();
                              bool sonuc = await authcontroller.loginwithpass(
                                  _email, _password);
                              if (sonuc) {
                                Get.off(() => const FeedPage());
                              }
                            }
                          },
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
                          onPressed: () async {
                            bool sonuc = await authcontroller.loginwithgoogle();
                            if (sonuc) {
                              Get.offAll(() => const FeedPage());
                            }
                          },
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
                        child: const Text('Hemen Üye Ol'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
