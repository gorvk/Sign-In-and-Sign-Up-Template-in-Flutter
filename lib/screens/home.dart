import 'package:TodoApp/screens/components/appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Column(
          children: [
            Container(
              child: Text(_auth.currentUser.email),
              margin: EdgeInsets.only(top: 10),
            ),
            Container(
              margin: EdgeInsets.only(top:200),
              child: MaterialButton(
                onPressed: () async {
                  await _auth.signOut();
                  Navigator.pop(context, '/wrapper');
                },
                color: Colors.blue,
                child: Text(
                  "SIGN OUT",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
