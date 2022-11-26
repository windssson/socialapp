// ignore: file_names
import 'package:flutter/material.dart';
import 'package:meslek_agi/constant/constant.dart';
import 'package:meslek_agi/post/post_model.dart';

// ignore: must_be_immutable
class PostCard extends StatefulWidget {
  PostCard({super.key, required this.post});
  Post post;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
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
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/profil3.PNG'),
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
                        'Devran Aktı',
                        style: Constant().cardbaslik,
                      ),
                      Text(
                        '1 saat önce',
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
            /* SizedBox(
              width: double.infinity,
              child: Image.asset('assets/images/profil3.PNG'),
            ), */
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                'Hello World',
                style: Constant().posticerik,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: const [
                SizedBox(
                  width: 10,
                ),
                Expanded(child: Text('35 kişi beğendi')),
                Icon(Icons.comment),
                SizedBox(
                  width: 20,
                ),
                Icon(Icons.favorite_border_sharp),
                SizedBox(
                  width: 10,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
