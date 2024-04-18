// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/resources/auth_method.dart';
import 'package:provider/provider.dart';
import 'package:instagram/models/user.dart' as model;

class MobileScreenLayout extends StatefulWidget {
  MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  String username = "";

  @override
  void initState() {
    super.initState();
    getUsername();
  }

  // void getUsername() async {
  //   User? currentUser = FirebaseAuth.instance.currentUser;
  //   if (currentUser != null) {
  //     try {
  //       DocumentSnapshot snap = await FirebaseFirestore.instance
  //           .collection('users')
  //           .doc(currentUser.uid)
  //           .get();

  //       var data = snap.data() as Map<String, dynamic>?; // Cast as Map
  //       if (data != null) {
  //         setState(() {
  //           username = data['username']
  //               as String; // Ensure 'username' is cast as String
  //         });
  //       } else {
  //         print("No data available for user: ${currentUser.uid}");
  //       }
  //     } catch (e) {
  //       print('Failed to fetch user data: $e');
  //     }
  //   } else {
  //     print("No user logged in.");
  //   }
  // }

  void getUsername() async {
    var userDetails = await AuthMethods().getUserDetails();

    if (userDetails != null) {
      setState(() {
        username = userDetails['username'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(username, style: TextStyle(color: Colors.white)),
      ),
    );
    ;
  }
}
