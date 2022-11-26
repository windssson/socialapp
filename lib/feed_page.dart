import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:meslek_agi/auth/auth_controller.dart';
import 'package:meslek_agi/chat/chat_page.dart';
import 'package:meslek_agi/constant/constant.dart';
import 'package:meslek_agi/home/home_page.dart';
import 'package:meslek_agi/newpost/new_post.dart';
import 'package:meslek_agi/profil/profil_page.dart';
import 'package:meslek_agi/search/search.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final authcontroller = Get.put(AuthController());
  int selecttab = 0;
  List<Widget> screen = [
    const HomePage(),
    const SearchPage(),
    const NewPostPage(),
    const ChatPage(),
    const ProfilPage()
  ];
  @override
  void initState() {
    super.initState();
    authcontroller.logincontrol();
  }

  List<IconData> ikonlar = [
    Icons.mode_comment,
    Icons.search,
    Icons.camera_alt,
    Icons.chat,
    Icons.person
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
      floatingActionButton: selecttab == 0 || selecttab == 4
          ? FloatingActionButton(
              onPressed: (() {}),
              child: const Icon(Icons.comment),
            )
          : const SizedBox(),
      body: screen.elementAt(selecttab),
      bottomNavigationBar: CupertinoTabBar(
          backgroundColor: Colors.white,
          activeColor: Colors.green,
          currentIndex: selecttab,
          onTap: (value) {
            setState(() {
              selecttab = value;
              authcontroller.logincontrol();
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
