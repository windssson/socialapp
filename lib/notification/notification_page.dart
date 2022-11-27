import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meslek_agi/notification/notification_service.dart';

class NotifPage extends StatefulWidget {
  const NotifPage({super.key});

  @override
  State<NotifPage> createState() => _NotifPageState();
}

class _NotifPageState extends State<NotifPage> {
  var notifcontroller = Get.put(NotifController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Bildirimler',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Card(
                elevation: 0,
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://lh3.googleusercontent.com/a/ALm5wu14Zu4ogc_1dqNLXQLUC7YTmC5kBfW2OqB2DHP68bE=s96-c'),
                  ),
                  title: Row(
                    children: const [
                      Text(
                        'Devran Aktı ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('sizi takip etmeye başladı')
                    ],
                  ),
                  subtitle: const Text('21 dk önce'),
                ),
              )
            ],
          ),
        ));
  }
}
