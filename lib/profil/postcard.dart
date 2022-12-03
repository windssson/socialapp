// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:meslek_agi/auth/auth_controller.dart';
import 'package:meslek_agi/constant/constant.dart';
import 'package:meslek_agi/post/post_model.dart';

// ignore: must_be_immutable
class PostCard extends StatefulWidget {
  PostCard({super.key, required this.post});
  PostModel post;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  var fauth = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          //color: Colors.blue.withOpacity(0.08),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.post.photo),
                  radius: 25,
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.post.name,
                        style: Constant().cardbaslik,
                      ),
                      Text(
                        widget.post.zaman.toLocal().toString(),
                        style: Constant().cardsaat,
                      )
                    ],
                  ),
                ),
                IconButton(
                    onPressed: (() {
                      Get.bottomSheet(Material(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        child: Wrap(
                          direction: Axis.vertical,
                          runAlignment: WrapAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                top: 5,
                              ),
                              height: 5,
                              width: Get.width / 3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.black26),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextButton.icon(
                              onPressed: () {
                                Get.back();
                                gonderiDuzenle();
                              },
                              icon: const Icon(
                                IconlyLight.edit_square,
                                size: 28,
                                color: Colors.grey,
                              ),
                              label: const Text(
                                'Düzenle',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () {
                                Get.back();
                                gonderiSil(widget.post.gonderiid);
                              },
                              icon: const Icon(
                                IconlyLight.delete,
                                size: 28,
                                color: Colors.grey,
                              ),
                              label: const Text(
                                'Sil',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () {
                                Get.back();
                                gonderiPaylas();
                              },
                              icon: const Icon(
                                IconlyLight.send,
                                size: 30,
                                color: Colors.grey,
                              ),
                              label: const Text(
                                'Paylaş',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ));
                    }),
                    icon: const Icon(Icons.more_vert))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            /* SizedBox(
              width: double.infinity,
              child: Image.asset('assets/images/profil3.PNG'),
            ), */
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                widget.post.icerik,
                style: Constant().posticerik,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Expanded(child: Text(widget.post.begeni.toString())),
                const Icon(Icons.comment),
                const SizedBox(
                  width: 20,
                ),
                const Icon(Icons.favorite_border_sharp),
                const SizedBox(
                  width: 10,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  gonderiSil(String postid) async {
    Get.defaultDialog(
      title: 'Gönderi Silinsin mi?',
      content: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Gönderiyi silmek istediğinizden emin misiniz ? \n '),
      ),
      actions: [
        ElevatedButton(
            onPressed: (() async {
              var sonuc = await FirebaseFirestore.instance
                  .collection('Users')
                  .doc(fauth.cuser!.userid)
                  .collection('gonderi')
                  .doc(postid)
                  .delete()
                  .then((value) {
                return true;
              }).onError((error, stackTrace) => false);
              await FirebaseFirestore.instance
                  .collection('Users')
                  .doc(fauth.cuser!.userid)
                  .set({'postsayisi': FieldValue.increment(-1)},
                      SetOptions(merge: true));
              if (sonuc) {
                Get.back();
                Get.snackbar('Başarılı', 'Gönderi silindi.');
              }
            }),
            child: const Text('Sil')),
        ElevatedButton(
            onPressed: (() {
              Get.back();
            }),
            child: const Text('İptal Et')),
      ],
    );
  }

  gonderiDuzenle() {
    Get.snackbar('Hoopss', 'Henüz geliştirilme aşamasında');
  }

  gonderiPaylas() {
    Get.snackbar('Hoopss', 'Henüz geliştirilme aşamasında.');
  }
}
