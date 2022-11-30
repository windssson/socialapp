// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meslek_agi/auth/auth_controller.dart';
import 'package:meslek_agi/constant/constant.dart';
import 'package:meslek_agi/profil/takipci_model.dart';

// ignore: must_be_immutable
class TakipciCard extends StatefulWidget {
  TakipciCard({super.key, required this.post});
  TakipciModel post;

  @override
  State<TakipciCard> createState() => _TakipciCard();
}

class _TakipciCard extends State<TakipciCard> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var fauth = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
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
                        widget.post.meslek,
                        style: Constant().cardsaat,
                      )
                    ],
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      await takibibirak(
                          fauth.cuser!.userid, widget.post.userid);
                    },
                    child: const Text('Takibi Bırak'))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> takibibirak(String myuid, String userid) async {
    await firestore
        .collection('Users')
        .doc(myuid)
        .collection('takipler')
        .doc(userid)
        .delete();
    await firestore.collection('Users').doc(myuid).set(
        {'takipedilen': FieldValue.increment(-1)}, SetOptions(merge: true));
    await firestore
        .collection('Users')
        .doc(userid)
        .set({'takipci': FieldValue.increment(-1)}, SetOptions(merge: true));
    return true;
  }
}
