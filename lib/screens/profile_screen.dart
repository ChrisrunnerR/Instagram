import 'package:flutter/material.dart';
import 'package:instagram/resources/auth_method.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              AuthMethods().signOut();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
