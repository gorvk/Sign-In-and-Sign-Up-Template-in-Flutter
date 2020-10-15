import 'package:TodoApp/screens/authenticate/portal.dart';
import 'package:TodoApp/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  
  final _auth = FirebaseAuth.instance;
  
  Stream<User> get authStateChanges {
    return _auth.authStateChanges();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      print('Portal');
      return Portal();
    } else {
      print('Home');
      return Home();
    }
  }
}
