import 'package:flutter/material.dart';
import 'package:instagram/screens/add_post_screen.dart';
import 'package:instagram/screens/feed_screen.dart';
import 'package:instagram/screens/profile_screen.dart';
import 'package:instagram/screens/search_screen.dart';

const webScreenSize = 600;

const homeScreenItems = [
  FieldScreen(),
  SearchScreen(),
  AddPostScreen(),
  Text("saved "),
  ProfileScreen(),
];
