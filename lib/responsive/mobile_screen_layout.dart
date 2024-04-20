// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/providers/user_provider.dart';
import 'package:instagram/resources/auth_method.dart';
import 'package:instagram/screens/add_post_screen.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/global_variables.dart';
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
  late PageController pageController;
  int _page = 0;
  @override
  void initState() {
    super.initState();
    addData();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  void NavigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: PageView(
        //in global variables
        children: homeScreenItems,
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: [
          BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.home,
                color: _page == 0 ? primaryColor : secondaryColor),
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.search,
                color: _page == 1 ? primaryColor : secondaryColor),
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.add_circle,
                color: _page == 2 ? primaryColor : secondaryColor),
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.favorite,
                color: _page == 3 ? primaryColor : secondaryColor),
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.person,
                color: _page == 4 ? primaryColor : secondaryColor),
            backgroundColor: primaryColor,
          ),
        ],
        onTap: NavigationTapped,
      ),
    );
    ;
  }
}
