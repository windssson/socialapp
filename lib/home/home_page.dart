
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meslek_agi/auth/auth_controller.dart';
import 'package:meslek_agi/constant/constant.dart';
import 'package:meslek_agi/post/post_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final auth = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('timeline')
              .doc(auth.cuser!.userid)
              .collection('gonderiler')
              .orderBy('zaman', descending: true)
              .limit(100)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Gönderiler çekilirken hata');
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
                    child: postcardbuild(oankipost),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  postcardbuild(PostModel post) {
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
                  backgroundImage: NetworkImage(post.photo),
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
                        post.name,
                        style: Constant().cardbaslik,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        tarihcevir(post.zaman),
                        style: Constant().cardsaat,
                      )
                    ],
                  ),
                ),
                const Icon(Icons.more_vert)
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                post.icerik,
                style: Constant().posticerik,
              ),
            ),
            /*
            //Fotoğraflı gönderiler için
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: Image.asset('assets/images/profil3.PNG'),
              ),
            ), */
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Expanded(child: Text('${post.begeni} kişi beğendi')),
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

  String tarihcevir(DateTime time) {
    int simdikizaman = DateTime.now().millisecondsSinceEpoch;
    int postzamani = time.millisecondsSinceEpoch;
    int zamanfarki = ((simdikizaman - postzamani) / 1000).round();
    int dk = zamanfarki ~/ 60;
    int saat = dk ~/ 60;
    int gun = saat ~/ 24;

    if (zamanfarki < 60) {
      return 'Az Önce';
    } else if (dk < 60) {
      return '$dk dakika önce';
    } else if (saat < 60) {
      return '$saat saat önce';
    } else {
      return '$gun gün önce';
    }
  }
}
