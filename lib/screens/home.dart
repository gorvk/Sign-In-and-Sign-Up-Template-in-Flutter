import 'package:TodoApp/screens/components/appbar.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  // final CollectionReference notes =
  //     FirebaseFirestore.instance.collection('notes');

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
              margin: EdgeInsets.only(top: 200),
              child: MaterialButton(
                onPressed: () async {
                  await _auth.signOut();
                },
                color: Colors.blue,
                child: Text(
                  "SIGN OUT",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            // MaterialButton(
            //   onPressed: () {
            //     notes
            //         .add({
            //           'Title': "Add Notes",
            //           'Todo': "Done Added",
            //         })
            //         .then((value) => print("User Added"))
            //         .catchError((error) => print("Failed to add note!!"));
            //   },
            //   color: Colors.blue,
            //   child: Text(
            //     "Add Note",
            //     style: TextStyle(color: Colors.white),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
