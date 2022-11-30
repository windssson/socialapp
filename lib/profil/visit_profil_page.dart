import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:meslek_agi/auth/auth_controller.dart';
import 'package:meslek_agi/constant/constant.dart';
import 'package:meslek_agi/notification/notification_page.dart';
import 'package:meslek_agi/post/post_model.dart';
import 'package:meslek_agi/profil/postcard.dart';
import 'package:meslek_agi/search/search_controller.dart';

// ignore: must_be_immutable
class VisitProfilPageFuture extends StatefulWidget {
  VisitProfilPageFuture({super.key, required this.userid});
  String userid;

  @override
  State<VisitProfilPageFuture> createState() => _VisitProfilPageFuture();
}

class _VisitProfilPageFuture extends State<VisitProfilPageFuture> {
  @override
  Widget build(BuildContext context) {
    String uid = widget.userid;

    final auth = Get.put(AuthController());
    final scontrol = Get.put(SearchController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.green),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
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
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('Users').doc(uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            DocumentSnapshot veri = snapshot.data!;
            Map gveri = veri.data() as Map;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundImage: NetworkImage(gveri['profilphoto']),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                gveri['name'],
                                style: Constant().profilname,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                gveri['meslek'],
                                style: Constant().cardbaslik,
                              )
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: (() {}),
                          icon: const Icon(
                            IconlyBroken.more_square,
                            size: 30,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        gveri['bio'],
                        textAlign: TextAlign.start,
                        style: Constant().biobaslik,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              gveri['postsayisi'].toString(),
                              style: Constant().flowbaslik,
                            ),
                            Text(
                              'Gönderi',
                              style: Constant().flowtext,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 35,
                          child: VerticalDivider(
                            color: Colors.black,
                            thickness: 2,
                            indent: 5,
                            endIndent: 0,
                            width: 10,
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              gveri['takipci'].toString(),
                              style: Constant().flowbaslik,
                            ),
                            Text(
                              'Takipçi',
                              style: Constant().flowtext,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 35,
                          child: VerticalDivider(
                            color: Colors.black,
                            thickness: 2,
                            indent: 5,
                            endIndent: 0,
                            width: 20,
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              gveri['takipedilen'].toString(),
                              style: Constant().flowbaslik,
                            ),
                            Text(
                              'Takip',
                              style: Constant().flowtext,
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: FutureBuilder(
                        future: takipcontrol(auth.cuser!.userid, widget.userid),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data!) {
                              return ElevatedButton(
                                onPressed: () async {
                                  var sonuc = await scontrol.takipEt(
                                      auth.cuser!.userid,
                                      widget.userid,
                                      gveri['meslek'],
                                      gveri['name'],
                                      gveri['profilphoto']);
                                  if (sonuc) {
                                    setState(() {});
                                  }
                                },
                                child: const Text('Takip Et'),
                              );
                            } else {
                              return ElevatedButton(
                                onPressed: () async {
                                  var sonuc = await scontrol.takipBirak(
                                      auth.cuser!.userid, widget.userid);
                                  if (sonuc) {
                                    setState(() {});
                                  }
                                },
                                child: const Text('Takibi Bırak'),
                              );
                            }
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    gonderibuilder()
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  gonderibuilder() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.userid)
          .collection('gonderi')
          .orderBy('zaman', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Gönderi bulunamadı');
        } else if (snapshot.hasData) {
          var veri = snapshot.data;
          List<PostModel> tumgonderi = [];

          for (DocumentSnapshot<Map<String, dynamic>> i in veri!.docs) {
            PostModel gonderi = PostModel.fromjson(i.data()!);
            tumgonderi.add(gonderi);
          }

          return ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: tumgonderi.length,
            itemBuilder: (context, index) {
              PostModel oankipost = tumgonderi[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: PostCard(
                  post: oankipost,
                ),
              );
            },
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Future<bool> takipcontrol(String myuid, String uid) async {
    DocumentSnapshot sonuc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(myuid)
        .collection('takipler')
        .doc(uid)
        .get();

    if (sonuc.exists) {
      return false;
    } else {
      return true;
    }
  }
}
