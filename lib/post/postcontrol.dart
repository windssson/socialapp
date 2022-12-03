
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
    await fbase
        .collection('Users')
        .doc(post.userid)
        .set({'postsayisi': FieldValue.increment(1)}, SetOptions(merge: true));
    QuerySnapshot takipedenler = await fbase
        .collection('Users')
        .doc(post.userid)
        .collection('takipeden')
        .get();
    // ignore: avoid_function_literals_in_foreach_calls
    takipedenler.docs.forEach((element) async {
      var veri = element.data() as Map<String, dynamic>;
      post.gonderiid = eklenecekid;
      await fbase
          .collection('timeline')
          .doc(veri['userid'])
          .collection('gonderiler')
          .doc(eklenecekid)
          .set(post.toMap());
    });

    return true;
  }

  
}
