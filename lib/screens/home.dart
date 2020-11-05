// import 'package:audio_picker/audio_picker.dart';
// import 'package:audioplayers/audioplayers.dart';
import 'package:TodoApp/screens/components/NavDrawer.dart';
import 'package:TodoApp/screens/newAudio.dart';
import 'package:TodoApp/screens/userProfile.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white10,
        iconTheme: IconThemeData(
          color: Color(0xff092E34),
        ),
        actions: [
          Container(
            padding: EdgeInsets.all(10),
            child: MaterialButton(
              disabledColor: Colors.transparent,
              shape: CircleBorder(),
              child: Icon(
                Icons.account_circle,
                color: Colors.white,
                size: 35,
              ),
              color: Color(0xff092E34),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserProfile(),
                  ),
                );
              },
            ),
          ),
        ],
        elevation: 0.0,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewAudio(),
            ),
          );
        },
        backgroundColor: Color(0xff092E34),
      ),
      body: Center(
        child: Text("Recently Added"),
      ),
    );
  }
}

// final CollectionReference notes =
//     FirebaseFirestore.instance.collection('notes');

// body: Center(
//   child:
//       MaterialButton(
//         onPressed: () {
//           notes
//               .add({
//                 'Title': "Add Notes",
//                 'Todo': "Done Added",
//               })
//               .then((value) => print("User Added"))
//               .catchError((error) => print("Failed to add note!!"));
//         },
//         color: Colors.blue,
//         child: Text(
//           "Add Note",
//           style: TextStyle(color: Colors.white),
//         ),
//     ),
// ),
