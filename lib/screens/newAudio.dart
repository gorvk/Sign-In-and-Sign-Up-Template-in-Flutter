import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_storage/firebase_storage.dart';

class NewAudio extends StatefulWidget {
  @override
  _NewAudioState createState() => _NewAudioState();
}

class _NewAudioState extends State<NewAudio> {
  String _absolutePath;
  File _fileToUpload;
  AudioPlayer audioPlayer;
  String uploadStatus = " ";
  bool pause = false;
  bool initialPlay = true;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final fileName = TextEditingController();

  List<String> extensions;

  final CollectionReference audiofiles =
      FirebaseFirestore.instance.collection('audiofiles');

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Color(0xff092E34),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 100),
                child: Text(
                  "Upload a new Podcast",
                ),
              ),
              _absolutePath == null
                  ? Container(
                      margin: EdgeInsets.only(top: 30),
                      child: Text("no file picked"),
                    )
                  : Container(
                      margin: EdgeInsets.only(top: 30),
                      child: Column(
                        children: [
                          Text(
                            "File Picked - ",
                            style: TextStyle(),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 50, right: 50, bottom: 10),
                            child: Text(
                              "$_absolutePath",
                              style: TextStyle(),
                            ),
                          ),
                        ],
                      ),
                    ),
              MaterialButton(
                child: Text(
                  "Pick the file",
                  style: TextStyle(color: Colors.white),
                ),
                color: Color(0xff092E34),
                onPressed: () {
                  openAudioPicker();
                },
              ),
              Container(
                padding: EdgeInsets.only(left: 60, right: 60),
                margin: EdgeInsets.only(top: 20, bottom: 30),
                child: TextFormField(
                  controller: fileName,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff092E34),
                      ),
                    ),
                    hintStyle: TextStyle(
                      color: Color(0xff092E34),
                    ),
                    hintText: "File Name",
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter a Name";
                    }
                    return null;
                  },
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.cloud_upload,
                  size: 40,
                ),
                onPressed: () {
                  uploadImageToFirebase(context);
                },
              ),
              Text(uploadStatus),
            ],
          ),
        ),
      ),
    );
  }

  void openAudioPicker() async {
    var file = await FilePicker.getFile(
        type: FileType.audio, allowedExtensions: extensions);
    setState(() {
      uploadStatus = " ";
      _fileToUpload = file;
      _absolutePath = file.path;
    });
  }



  Future uploadImageToFirebase(BuildContext context) async {
    // String fileName = _absolutePath;
    setState(() {
      uploadStatus = "Uploading...";
    });
    File file = _fileToUpload;
    Reference ref = firebaseStorage.ref(fileName.text);
    await ref.putFile(file);
    ref.getDownloadURL().then(
      (url) {
        audiofiles.add(
          {
            'name': fileName.text,
            'url': url,
          },
        ).then((value) {
          setState(() {
            uploadStatus = "Uploaded.";
          });
        }).catchError((error) => print("Failed to upload podcast!!"));
      },
    );
  }
}

// body: Center(
//   child:
//       MaterialButton(
//         onPressed: () {
//
//         },
//         color: Colors.blue,
//         child: Text(
//           "Add Note",
//           style: TextStyle(color: Colors.white),
//         ),
//     ),
// ),

  //             _absolutePath != null
  //                 ? Container(
  //                     margin: EdgeInsets.only(top: 20, left: 80, right: 80),
  //                     color: Color(0x88092E34),
  //                     padding: EdgeInsets.all(0),
  //                     child: Row(
  //                       children: [
  //                         pause == false
  //                             ? initialPlay == true
  //                                 ? Container(
  //                                     margin: EdgeInsets.only(left: 55),
  //                                     child: IconButton(
  //                                       icon: Icon(Icons.play_arrow),
  //                                       onPressed: () {
  //                                         playAudio();
  //                                       },
  //                                     ),
  //                                   )
  //                                 : Container(
  //                                     margin: EdgeInsets.only(left: 55),
  //                                     child: IconButton(
  //                                       icon: Icon(Icons.play_arrow),
  //                                       onPressed: () {
  //                                         resumeAudio();
  //                                       },
  //                                     ),
  //                                   )
  //                             : Container(
  //                                 margin: EdgeInsets.only(left: 55),
  //                                 child: IconButton(
  //                                   icon: Icon(Icons.pause),
  //                                   onPressed: () {
  //                                     pauseAudio();
  //                                   },
  //                                 ),
  //                               ),
  //                         IconButton(
  //                           icon: Icon(Icons.stop),
  //                           onPressed: () {
  //                             stopAudio();
  //                           },
  //                         ),
  //                       ],
  //                     ),
  //                   )
  //                 : Container(),
  // void playAudio() async {
  //   await audioPlayer.play(_absolutePath);
  //   setState(() {
  //     pause = !pause;
  //   });
  // }

  // void pauseAudio() async {
  //   await audioPlayer.pause();
  //   setState(() {
  //     pause = !pause;
  //   });
  // }

  // void stopAudio() async {
  //   await audioPlayer.stop();
  //   setState(() {
  //     pause = false;
  //   });
  // }

  // void resumeAudio() async {
  //   await audioPlayer.resume();
  // }