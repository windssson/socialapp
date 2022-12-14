import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:meslek_agi/auth/auth_controller.dart';
import 'package:meslek_agi/constant/constant.dart';
import 'package:meslek_agi/post/post_model.dart';
import 'package:meslek_agi/profil/postcard.dart';
import 'package:meslek_agi/profil/takipci_model.dart';
import 'package:meslek_agi/profil/takipcicard.dart';

class ProfilPageFuture extends StatefulWidget {
  const ProfilPageFuture({super.key});

  @override
  State<ProfilPageFuture> createState() => _ProfilPageFuture();
}

class _ProfilPageFuture extends State<ProfilPageFuture> {
  final authcontroller = Get.put(AuthController());
  int pagecontrol = 1;

  @override
  Widget build(BuildContext context) {
    String uid = authcontroller.cuser!.userid;
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('Users').doc(uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            DocumentSnapshot veri = snapshot.data!;
            Map gveri = veri.data() as Map;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
                            IconlyBroken.edit_square,
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
                              style: Constant()
                                  .flowbaslik
                                  .copyWith(color: Colors.green),
                            ),
                            Text(
                              'G??nderi',
                              style: Constant()
                                  .flowtext
                                  .copyWith(color: Colors.green),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 35,
                          child: VerticalDivider(
                            color: Colors.black,
                            thickness: 1.5,
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
                              'Takip??i',
                              style: Constant().flowtext,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 35,
                          child: VerticalDivider(
                            color: Colors.black,
                            thickness: 1.5,
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
                      child: ElevatedButton(
                        child: const Text('Profili D??zenle'),
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    profilpagebuilder(),
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

  profilpagebuilder() {
    if (pagecontrol == 0) {
      return gonderibuilder();
    } else {
      return takipettiklerim();
    }
  }

  gonderibuilder() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .doc(authcontroller.cuser!.userid)
          .collection('gonderi')
          .orderBy('zaman', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('G??nderi bulunamad??');
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

  takipettiklerim() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .doc(authcontroller.cuser!.userid)
          .collection('takipler')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('G??nderi bulunamad??');
        } else if (snapshot.hasData) {
          var veri = snapshot.data;
          List<TakipciModel> tumgonderi = [];

          for (DocumentSnapshot<Map<String, dynamic>> i in veri!.docs) {
            TakipciModel gonderi = TakipciModel.fromjson(i.data()!);
            tumgonderi.add(gonderi);
          }
          return ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: tumgonderi.length,
            itemBuilder: (context, index) {
              TakipciModel oankipost = tumgonderi[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TakipciCard(
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

   takipcilerim() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .doc(authcontroller.cuser!.userid)
          .collection('takipler')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('G??nderi bulunamad??');
        } else if (snapshot.hasData) {
          var veri = snapshot.data;
          List<TakipciModel> tumgonderi = [];

          for (DocumentSnapshot<Map<String, dynamic>> i in veri!.docs) {
            TakipciModel gonderi = TakipciModel.fromjson(i.data()!);
            tumgonderi.add(gonderi);
          }
          return ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: tumgonderi.length,
            itemBuilder: (context, index) {
              TakipciModel oankipost = tumgonderi[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TakipciCard(
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
}
