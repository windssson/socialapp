import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meslek_agi/auth/auth_controller.dart';
import 'package:meslek_agi/search/search_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final userc = Get.put(AuthController());
  String aramatext = 'asd';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: SizedBox(
            height: 40,
            child: TextField(
              textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                hintText: 'Arama',
              ),
              onChanged: (value) {
                setState(() {
                  aramatext = value;
                  if (aramatext == '') {
                    aramatext = 'asd';
                  }
                });
              },
            ),
          ),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .where('nameshort',
                  isGreaterThanOrEqualTo: aramatext.toLowerCase())
              .snapshots(),
          builder: (context, snapshot) {
            return (snapshot.connectionState == ConnectionState.waiting)
                ? Container()
                : ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      List<QueryDocumentSnapshot> list = snapshot.data!.docs;

                      var data = list[index];

                      if (!(data['userid'] == userc.cuser!.userid)) {
                        if (data['name']
                            .toString()
                            .toLowerCase()
                            .startsWith(aramatext.toLowerCase())) {
                          return SearchCard(
                              name: data['name'],
                              myuid: userc.cuser!.userid,
                              userid: data['userid'],
                              meslek: data['meslek'],
                              photourl: data['profilphoto']);
                        }
                      }
                      return Container();
                    },
                  );
          },
        ));
  }
}
