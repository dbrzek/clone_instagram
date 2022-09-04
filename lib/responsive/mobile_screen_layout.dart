import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../models/users.dart' as model;

class MobileScrenLayout extends StatefulWidget {
  const MobileScrenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScrenLayout> createState() => _MobileScrenLayoutState();
}

class _MobileScrenLayoutState extends State<MobileScrenLayout> {
  @override
  Widget build(BuildContext context) {
    final model.User? user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: user == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(child: Text("${user.username}")),
    );
  }
}
