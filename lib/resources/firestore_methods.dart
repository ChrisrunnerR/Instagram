import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(String description, Uint8List file, String uid,
      String username, String profImage) async {
    String result = "Some error occured";
    try {
      if (description.isNotEmpty || file != null || uid.isNotEmpty) {
        String photoUrl =
            await StorageMethods().uploadImageToStorage('posts', file, true);
        String postId = const Uuid().v1();

        await _firestore.collection('posts').doc(postId).set({
          'description': description,
          'username': username,
          'uid': uid,
          'postId': postId,
          'datePublished': DateTime.now(),
          'postUrl': photoUrl,
          'profImage': profImage,
          'likes': [],
        });
        result = "success";
      }
    } catch (err) {
      result = err.toString();
    }
    print(result);
    return result;
  }
}
