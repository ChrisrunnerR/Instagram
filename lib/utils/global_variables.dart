import 'package:flutter/material.dart';
import 'package:instagram/screens/add_post_screen.dart';
import 'package:instagram/screens/feed_screen.dart';
import 'package:instagram/screens/profile_screen.dart';

const webScreenSize = 600;

const homeScreenItems = [
  FieldScreen(),
  Text("search"),
  AddPostScreen(),
  Text("saved "),
  ProfileScreen(),
];
