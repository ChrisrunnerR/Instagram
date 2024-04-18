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
  String email = "";

  @override
  void initState() {
    super.initState();
    getUsername();
  }

// should just be void
  void getUsername() async {
    var userDetails = await AuthMethods().getUserDetails();

    if (userDetails != null) {
      setState(() {
        username = userDetails['username'];
        email = userDetails['email'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page"), actions: <Widget>[
        IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () {
            AuthMethods().signOut();
          },
          tooltip: "Logout",
        )
      ]),
      body: Center(
        child: Text(username, style: TextStyle(color: Colors.white)),
      ),
    );
    ;
  }
}
