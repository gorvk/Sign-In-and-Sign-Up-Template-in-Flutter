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
        title: Text(
          "Recently Added",
          style: TextStyle(
            color: Color(0xff092E34),
          ),
        ),
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
                          return index == snapshot.data.length - 1
                              ? Container(
                                  color: Color(0x5E007486),
                                  margin: EdgeInsets.only(
                                    top: 5,
                                    right: 20,
                                    left: 20,
                                    bottom: 80,
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      snapshot.data[index]['name'],
                                      style:
                                          TextStyle(color: Color(0xff092E34)),
                                    ),
                                    onTap: () {
                                      playAudio(snapshot.data[index]['url']);
                                    },
                                  ))
                              : Container(
                                  color: Color(0x5E007486),
                                  margin: EdgeInsets.only(
                                    top: 5,
                                    right: 20,
                                    left: 20,
                                    bottom: 5,
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      snapshot.data[index]['name'],
                                      style:
                                          TextStyle(color: Color(0xff092E34)),
                                    ),
                                    onTap: () {
                                      playAudio(snapshot.data[index]['url']);
                                    },
                                  ));
                        });
                  }
                }),
          ),
          Container(
            margin: EdgeInsets.only(
              top: screenSize.height / 2 + 190,
            ),
            padding: EdgeInsets.only(bottom: 15),
            color: Color(0xFF007486),
            child: Row(
              children: [
                pause == false
                    ? Container(
                        margin: EdgeInsets.only(right: 10),
                        child: IconButton(
                          icon: Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 50,
                          ),
                          onPressed: () async {
                            setState(() {
                              pause = !pause;
                            });
                            await audioPlayer.play();
                          },
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.only(right: 10),
                        child: IconButton(
                          icon: Icon(
                            Icons.pause,
                            color: Colors.white,
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
                    color: Colors.white,
                    size: 50,
                  ),
                  onPressed: () {
                    stopAudio();
                  },
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                left: screenSize.width / 2 + 110,
                top: screenSize.height / 2 + 120),
            child: FloatingActionButton(
              backgroundColor: Color(0xFF007486),
              onPressed: () {
                setState(() {
                  _data = getFile();
                });
              },
              child: Icon(Icons.refresh),
            ),
          ),
        ],
      ),
    );
  }

  void playAudio(String url) async {
    setState(() {
      pause = !pause;
    });
    await audioPlayer.setUrl(url);
    await audioPlayer.play();
  }

  void pauseAudio() async {
    await audioPlayer.pause();
    setState(() {
      pause = !pause;
    });
  }

  void stopAudio() async {
    setState(() {
      pause = false;
    });
    await audioPlayer.stop();
  }

  // void resumeAudio() async {
  //   await audioPlayer.resume();
  // }
}
