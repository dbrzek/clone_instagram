import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/feed_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/add_post_screen.dart';
import '../screens/search_screen.dart';


const webScreenSize = 600;
var uid = FirebaseAuth.instance.currentUser!.uid;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const Text('4'),
  ProfileScren(uid: uid,),
];
