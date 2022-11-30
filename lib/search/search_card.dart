import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meslek_agi/profil/visit_profil_page.dart';
import 'package:meslek_agi/search/search_controller.dart';

// ignore: must_be_immutable
class SearchCard extends StatefulWidget {
  SearchCard(
      {super.key,
      required this.name,
      required this.userid,
      required this.meslek,
      required this.myuid,
      required this.photourl});
  String name;
  String meslek;
  String photourl;
  String userid;
  String myuid;

  @override
  State<SearchCard> createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  getTakip() async {}

  @override
  Widget build(BuildContext context) {
    final scontroller = Get.put(SearchController());

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      width: double.infinity,
      height: 80,
      child: InkWell(
        onTap: () {
          Get.to(() => VisitProfilPageFuture(userid: widget.userid));
        },
        child: ListTile(
          title: Text(widget.name),
          subtitle: Text(widget.meslek),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(widget.photourl),
          ),
          trailing: FutureBuilder(
            future: scontroller.takipcontrol(widget.myuid, widget.userid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!) {
                  return ElevatedButton(
                    child: const Text('Takip Et'),
                    onPressed: () async {
                      var sonuc = await scontroller.takipEt(
                          widget.myuid,
                          widget.userid,
                          widget.meslek,
                          widget.name,
                          widget.photourl);
                      if (sonuc) {
                        setState(() {});
                      }
                    },
                  );
                } else {
                  return ElevatedButton(
                    child: const Text('Takibi Bırak'),
                    onPressed: () async {
                      var sonuc = await scontroller.takipBirak(
                          widget.myuid, widget.userid);
                      if (sonuc) {
                        setState(() {});
                      }
                    },
                  );
                }
              } else {
                return const SizedBox(
                    width: 15, height: 15, child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
