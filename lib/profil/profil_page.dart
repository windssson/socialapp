import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:meslek_agi/auth/auth_controller.dart';
import 'package:meslek_agi/constant/constant.dart';
import 'package:meslek_agi/post/post_model.dart';
import 'package:meslek_agi/profil/postCard.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  final authcontroller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: SingleChildScrollView(
          physics:const BouncingScrollPhysics(),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundImage:
                        NetworkImage(authcontroller.cuser!.photourl),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          authcontroller.cuser!.name,
                          style: Constant().profilname,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          authcontroller.cuser!.meslek,
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
                  authcontroller.cuser!.bio,
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
                        authcontroller.cuser!.postSayisi.toString(),
                        style: Constant().flowbaslik,
                      ),
                      Text(
                        'Post',
                        style: Constant().flowtext,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 35,
                    child: VerticalDivider(
                      color: Colors.black,
                      thickness: 2,
                      indent: 5,
                      endIndent: 0,
                      width: 10,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        authcontroller.cuser!.takipci.toString(),
                        style: Constant().flowbaslik,
                      ),
                      Text(
                        'Takipçi',
                        style: Constant().flowtext,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 35,
                    child: VerticalDivider(
                      color: Colors.black,
                      thickness: 2,
                      indent: 5,
                      endIndent: 0,
                      width: 20,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        authcontroller.cuser!.takipedilen.toString(),
                        style: Constant().flowbaslik,
                      ),
                      Text(
                        'Takipçi',
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
                  child: const Text('Profili Düzenle'),
                  onPressed: () {},
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: PostCard(
                  post: Post('postid', "auth", DateTime.now(), "icerik"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: PostCard(
                  post: Post('postid', "auth", DateTime.now(), "icerik"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: PostCard(
                  post: Post('postid', "auth", DateTime.now(), "icerik"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: PostCard(
                  post: Post('postid', "auth", DateTime.now(), "icerik"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: PostCard(
                  post: Post('postid', "auth", DateTime.now(), "icerik"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
