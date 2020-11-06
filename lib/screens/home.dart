import 'package:TodoApp/screens/components/NavDrawer.dart';
import 'package:TodoApp/screens/userProfile.dart';
// import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AudioPlayer audioPlayer;
  bool pause = false;
  bool initialPlay = true;
  Future _data;
  Future getFile() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("audiofiles").get();
    return qn.docs;
  }

  @override
  void initState() {
    super.initState();
    _data = getFile();
    audioPlayer = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

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
        body: Stack(
          children: [
            Container(
              child: FutureBuilder(
                  future: _data,
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Text("Loading"),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (_, index) {
                            return ListTile(
                              title: Text(
                                "${snapshot.data[index]['name']}\n${snapshot.data[index]['url']}",
                              ),
                              onTap: () {
                                playAudio(snapshot.data[index]['url']);
                              },
                            );
                          });
                    }
                  }),
            ),
            Container(
              margin: EdgeInsets.only(
                top: screenSize.height / 2 + 190,
              ),
              padding: EdgeInsets.only(bottom: 15),
              color: Color(0x88092E34),
              child: Row(
                children: [
                  pause == false
                      // ? initialPlay == true
                      ? Container(
                          margin: EdgeInsets.only(right: 10),
                          child: IconButton(
                            icon: Icon(
                              Icons.play_arrow,
                              size: 50,
                            ),
                            onPressed: () {
                              print(screenSize.height);
                            },
                          ),
                        )
                      // : Container(
                      //     child: IconButton(
                      //       icon: Icon(
                      //         Icons.play_arrow,
                      //         size: 50,
                      //       ),
                      //       onPressed: () {
                      //         resumeAudio();
                      //       },
                      //     ),
                      //   )
                      : Container(
                          margin: EdgeInsets.only(left: 55),
                          child: IconButton(
                            icon: Icon(
                              Icons.pause,
                              size: 50,
                            ),
                            onPressed: () {
                              pauseAudio();
                            },
                          ),
                        ),
                  IconButton(
                    icon: Icon(
                      Icons.stop,
                      size: 50,
                    ),
                    onPressed: () {
                      stopAudio();
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  void playAudio(String url) async {
    await audioPlayer.setUrl(url);
    await audioPlayer.play();
    setState(() {
      pause = !pause;
    });
  }

  void pauseAudio() async {
    await audioPlayer.pause();
    setState(() {
      pause = !pause;
    });
  }

  void stopAudio() async {
    await audioPlayer.stop();
    setState(() {
      pause = false;
    });
  }

  // void resumeAudio() async {
  //   await audioPlayer.resume();
  // }
}
