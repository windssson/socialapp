import 'dart:developer';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:meslek_agi/auth/auth_controller.dart';
import 'package:meslek_agi/constant/constant.dart';
import 'package:meslek_agi/notification/notification_page.dart';

class EditProfilPage extends StatefulWidget {
  const EditProfilPage({super.key});

  @override
  State<EditProfilPage> createState() => _EditProfilPageState();
}

class _EditProfilPageState extends State<EditProfilPage> {
  final _formkey = GlobalKey<FormState>();
  String name = '';
  String bio = '';
  Uint8List? _file;

  @override
  Widget build(BuildContext context) {
    InputDecoration decoration = InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
    );
    final auth = Get.put(AuthController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.green),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Meslek Ağı',
          style: Constant().nametext,
        ),
        actions: [
          IconButton(
            icon: Icon(
              IconlyBold.notification,
              color: Colors.green.shade700,
            ),
            onPressed: () {
              Get.to(() => const NotifPage());
            },
          ),
          const SizedBox(
            width: 20,
          ),
        ],
        toolbarHeight: 50,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Text(
                  'Sizi Biraz Tanıyalım mı ?',
                  style: Constant().baslik,
                ),
                const SizedBox(
                  height: 20,
                ),
                Stack(children: [
                  _file == null
                      ? const CircleAvatar(
                          radius: 80,
                          backgroundImage: AssetImage('assets/images/user.png'),
                        )
                      : CircleAvatar(
                          radius: 80,
                          backgroundImage: MemoryImage(_file!),
                        ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                        onPressed: () {
                          showdialog(context);
                        },
                        icon: const Icon(
                          IconlyBold.camera,
                          size: 35,
                          color: Colors.green,
                        )),
                  )
                ]),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: decoration.copyWith(hintText: 'Adınız'),
                  validator: (value) {
                    if (value!.length < 5) {
                      return 'Adınız en az 5 karakter olmalı';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (newValue) {
                    name = newValue!;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: decoration.copyWith(hintText: 'Biyografiniz'),
                  minLines: 4,
                  maxLines: 6,
                  validator: (value) {
                    if (value!.length < 5) {
                      return 'Bionuz en az 5 karakter olmalı';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (newValue) {
                    bio = newValue!;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: (() async {
                        if (_file == null) {
                          Get.snackbar(
                              'Hata', 'Lütfen profil fotoğrafı seçiniz.');
                        } else {
                          bool kontrol = _formkey.currentState!.validate();
                          if (kontrol) {
                            _formkey.currentState!.save();
                            var sonuc = await auth.userChangename(
                                photo: _file!, name: name, bio: bio);
                            if (sonuc) {
                              log('dosya yüklendi');
                            }
                          }
                        }
                      }),
                      child: const Text('Gönder Gelsin')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  showdialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Fotoğraf Ekle'),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Kamera'),
              onPressed: () async {
                Get.back();
                _file = await pickImage(ImageSource.camera);
                setState(() {});
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Galeri'),
              onPressed: () async {
                Get.back();
                _file = await pickImage(ImageSource.gallery);
                setState(() {});
              },
            )
          ],
        );
      },
    );
  }

  pickImage(ImageSource image) async {
    final ImagePicker imagepicker = ImagePicker();
    XFile? file = await imagepicker.pickImage(source: image);
    if (file != null) {
      return file.readAsBytes();
    }
    log('Fotoğraf seçilmedi');
  }
}
