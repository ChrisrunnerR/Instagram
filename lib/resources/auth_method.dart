import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram/resources/storage_methods.dart';
import 'package:instagram/models/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get user details
  Future<Map<String, dynamic>?> getUserDetails() async {
    User? currentUser = _auth.currentUser!;
    if (currentUser != null) {
      try {
        DocumentSnapshot snap =
            await _firestore.collection('users').doc(currentUser.uid).get();

        var data = snap.data() as Map<String, dynamic>?; // Cast as Map
        return data;
      } catch (e) {
        print('Failed to fetch user data: $e');
      }
    } else {
      print("No user logged in.");
    }

    return null;
  }

  // SIGNUP USER +   //Future because all calls to firebase are async
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    //compressed verions of file
    required Uint8List file,
  }) async {
    String result = "Some error occurred";
    //print("tetinsg");

    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        //print(cred.user!.uid);

        // call to store pfp in FireBaseStorage
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        // model.User user = model.User(
        //   username: username,
        //   uid: cred.user!.uid,
        //   email: email,
        //   bio: bio,
        //   photoUrl: photoUrl,
        //   following: [],
        //   followers: [],
        // );

        // username / bio / pfp
        await _firestore.collection("users").doc(cred.user!.uid).set({
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'bio': bio,
          'followers': [],
          'following': [],
          'photoUrl': photoUrl,
        });
        // await _firestore
        //     .collection("users")
        //     .doc(cred.user!.uid)
        //     .set(user.toJson());
        result = "success";
      }
    } catch (err) {
      result = err.toString();
    }
    print(result);
    return result;
  }

// LOG IN THE USER
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

// SIGNOUT

  Future<void> _signOut() async {
    await _auth.signOut();
  }
}
