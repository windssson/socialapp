import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconly/iconly.dart';
import 'package:meslek_agi/chat/chat_page.dart';
import 'package:meslek_agi/constant/constant.dart';
import 'package:meslek_agi/home/home_page.dart';
import 'package:meslek_agi/newpost/new_post.dart';
import 'package:meslek_agi/profil/profil_page.dart';
import 'package:meslek_agi/search/serach_page.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  int selecttab = 0;
  List<Widget> screen = [
    const HomePage(),
    const SearchPage(),
    const NewPostPage(),
    const ChatPage(),
    const ProfilPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.green),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Meslek Ağı',
          style: Constant().nametext,
        ),
        actions: [
          Icon(
            IconlyBold.notification,
            color: Colors.green.shade700,
          ),
          const SizedBox(
            width: 20,
          ),
        ],
        toolbarHeight: 50,
      ),
      body: screen.elementAt(selecttab),
      bottomNavigationBar: CupertinoTabBar(
          backgroundColor: Colors.white,
          activeColor: Colors.green,
          currentIndex: selecttab,
          onTap: (value) {
            setState(() {
              selecttab = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
              label: '',
              icon: Icon(IconlyBold.home),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(IconlyBroken.search),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(IconlyBroken.plus),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(IconlyBroken.chat),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(IconlyBroken.profile),
            )
          ]),
    );
  }
}
