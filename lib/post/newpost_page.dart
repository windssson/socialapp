
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meslek_agi/auth/auth_controller.dart';
import 'package:meslek_agi/post/post_model.dart';
import 'package:meslek_agi/post/postcontrol.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({super.key});

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  @override
  Widget build(BuildContext context) {
    var key = GlobalKey<FormFieldState>();
    String icerik = '';
    var auth = Get.put(AuthController());
    var postc = Get.put(PostController());

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text('Hemen Yazmaya Başla'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                style: const TextStyle(fontSize: 22),
                minLines: 4,
                maxLines: 12,
                decoration: InputDecoration(
                    hintText: 'Hello World',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                key: key,
                validator: (value) {
                  if (value!.length < 5) {
                    return 'Gönderi en az 6 harften oluşmalı';
                  } else {
                    return null;
                  }
                },
                onSaved: (newValue) {
                  icerik = newValue!;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                      onPressed: (() async {
                        if (key.currentState!.validate()) {
                          key.currentState!.save();
                          PostModel post = PostModel(
                              begeni: 0,
                              icerik: icerik,
                              gonderiid: '',
                              name: auth.cuser!.name,
                              photo: auth.cuser!.photourl,
                              userid: auth.cuser!.userid,
                              zaman: DateTime.now());
                          var sonuc = await postc.postla(post);
                          if (sonuc) {
                            Get.back();
                          } else {
                            Get.snackbar('Hata', 'Gönderi oluşturalamadı');
                          }
                        } else {
                          Get.snackbar(
                              'Hata', 'Lütfen gönderi alanını doldurun');
                        }
                      }),
                      child: const Text('Paylaş')))
            ],
          ),
        ));
  }
}
