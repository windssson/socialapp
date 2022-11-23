import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meslek_agi/auth/auth_controller.dart';
import 'package:meslek_agi/constant/constant.dart';
import 'package:meslek_agi/firebase_options.dart';
import 'package:meslek_agi/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  bool auth;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Supabase.initialize(
      url: Constant().supabaseurl,
      anonKey: Constant().supabaseapikey,
      debug: true);
  var controller = Get.put(AuthController());
  auth = await controller.logincontrol();
  runApp(MyApp(
    auth: auth,
  ));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key, required this.auth});
  bool auth;
  var controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
