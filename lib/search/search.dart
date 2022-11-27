import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Deneme"),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: (() async {
              DocumentSnapshot veri = await FirebaseFirestore.instance
                  .collection('Users')
                  .doc('SrKNxQAIXSb0jiPQJSCI6Ei15zD2')
                  .get();
              var gveri = veri.data() as Map<String, dynamic>;
              log(gveri['mail']);
            }),
            child: const Text('Veri Çek Yazdır')),
      ),
    );
  }
}
