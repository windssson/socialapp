import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconly/iconly.dart';
import 'package:meslek_agi/constant/constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.white),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Merhaba Devran',
          style: Constant().nametext,
        ),
        actions: [
          Icon(
            IconlyBold.notification,
            color: Colors.green.shade700,
          ),
          const SizedBox(
            width: 10,
          ),
        ],
        toolbarHeight: 40,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              storyRow(),
              const SizedBox(
                height: 15,
              ),
              postcardbuild(),
              const SizedBox(
                height: 20,
              ),
              postcardbuild(),
              const SizedBox(
                height: 20,
              ),
              postcardbuild(),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          fixedColor: Colors.green.shade900,
          type: BottomNavigationBarType.shifting,
          unselectedItemColor: Colors.black,
          showSelectedLabels: false,
          currentIndex: 0,
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(IconlyBold.home),
            ),
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(IconlyBroken.search),
            ),
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(IconlyBroken.plus),
            ),
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(IconlyBroken.chat),
            ),
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(IconlyBroken.profile),
            )
          ]),
    );
  }

  SizedBox postcardbuild() {
    return SizedBox(
      width: double.infinity,
      //color: Colors.blue.shade200,
      child: Column(
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
          SizedBox(
            width: double.infinity,
            child: Image.asset('assets/images/profil3.PNG'),
          ),
          const SizedBox(
            height: 10,
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
    );
  }

  SizedBox storyRow() {
    return SizedBox(
      height: 130,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            storyCardBuild(),
            storyCardBuild(),
            storyCardBuild(),
            storyCardBuild(),
            storyCardBuild(),
            storyCardBuild(),
          ],
        ),
      ),
    );
  }

  Padding storyCardBuild() {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: SizedBox(
        height: 130,
        child: Stack(
          children: [
            Container(
              width: 80,
              height: 100,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  )
                ],
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: AssetImage('assets/images/profil.PNG'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Positioned(
              bottom: 20,
              left: 22,
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/profil2.PNG'),
                radius: 16,
              ),
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: Text('Devran Aktı'),
            ),
          ],
        ),
      ),
    );
  }
}
