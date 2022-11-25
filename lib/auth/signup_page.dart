import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meslek_agi/auth/auth_controller.dart';
import 'package:meslek_agi/auth/signin_page.dart';
import 'package:meslek_agi/constant/constant.dart';
import 'package:meslek_agi/feed_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  double bosluk = Get.size.height / 50;
  String _email = '', _password = '';
  final _formkey = GlobalKey<FormState>();
  final authcontroller = Get.put(AuthController());
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
                  'Üye Ol',
                  style: Constant().baslik,
                ),
                SizedBox(
                  height: bosluk * 4,
                ),
                Form(
                  key: _formkey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      TextFormField(
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
                      SizedBox(
                        height: bosluk,
                      ),
                      TextFormField(
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
                      SizedBox(
                        height: bosluk * 3,
                      ),
                      SizedBox(
                        height: 45,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            bool validate = _formkey.currentState!.validate();
                            if (validate) {
                              _formkey.currentState!.save();
                              bool sonuc = await authcontroller.signupwithpass(
                                  _email, _password);
                              if (sonuc) {
                                Get.offAll(() => const FeedPage());
                              }
                            }
                          },
                          child: Text(
                            'Üye Ol',
                            style: Constant().girisinput,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: bosluk,
                      ),
                      SizedBox(
                        height: bosluk * 2,
                      ),
                      TextButton(
                          onPressed: (() {
                            Get.offAll(() => const SigninPage());
                          }),
                          child: const Text('Hemen Giriş Yap'))
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
