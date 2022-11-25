import 'package:flutter/material.dart';
import 'package:meslek_agi/constant/constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: SingleChildScrollView(
        child: Column(
          children: [
            //storyRow(),
            const SizedBox(
              height: 15,
            ),
            postcardbuild('Merhaba bu benim ilk postum.'),
            const SizedBox(
              height: 20,
            ),
            postcardbuild(
                'Selam merhaba, size muhteşem bir haberim var . Meslek Ağı ilk sürümü ile en kısa zamanda playde yayında olacak'),
            const SizedBox(
              height: 20,
            ),
            postcardbuild(
                'Merhaba , meslek ağı ilk sürümüünde sadece text tabanlı paylaşımlar olacak zamanla video ve görsel paylaşımlar olacak. Yayına alma sürecini erkene almak için şimdilik böyle bir yol izliyoruz. '),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  postcardbuild(String icerik) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: double.infinity,
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
                icerik,
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
