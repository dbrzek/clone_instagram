import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WebScrenLayout extends StatefulWidget {
  const WebScrenLayout({Key? key}) : super(key: key);

  @override
  State<WebScrenLayout> createState() => _WebScrenLayoutState();
}

class _WebScrenLayoutState extends State<WebScrenLayout> {
  String username = '';

  void getUsername() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    print(snap.data());
    setState(() {
      username = (snap.data() as Map<String, dynamic>)['username'];
    });
  }

  @override
  void initState() {
    getUsername();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("This is web")),
    );
  }
}