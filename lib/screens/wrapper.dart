import 'package:TodoApp/screens/authenticate/portal.dart';
import 'package:TodoApp/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return wrapperAuth();
  }

  Widget wrapperAuth() {
    if (_auth.currentUser == null) {
      print('Portal');
      return Portal();
    } else {
      print('Home');
      return Home();
    }
  }
}
