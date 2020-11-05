import 'package:flutter/material.dart';

class NewAudio extends StatefulWidget {
  @override
  _NewAudioState createState() => _NewAudioState();
}

class _NewAudioState extends State<NewAudio> {
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
      body: Center(
        child: Text("New Audio"),
      ),
    );
  }
}
