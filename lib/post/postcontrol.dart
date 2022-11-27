import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:meslek_agi/post/post_model.dart';

class PostController extends GetxController {
  var fbase = FirebaseFirestore.instance;

  Future<bool> postla(PostModel post) async {
    String eklenecekid = '';
    await fbase
        .collection('Users')
        .doc(post.userid)
        .collection('gonderi')
        .add(post.toMap())
        .then((value) {
      eklenecekid = value.id;
    });
    await fbase
        .collection('Users')
        .doc(post.userid)
        .collection('gonderi')
        .doc(eklenecekid)
        .set({'gonderiid': eklenecekid}, SetOptions(merge: true));

    return true;
  }
}
