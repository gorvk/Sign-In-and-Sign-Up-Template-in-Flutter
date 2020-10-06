import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:TodoApp/screens/wrapper.dart';
import 'package:TodoApp/screens/authenticate/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Wrapper(),
        '/signup': (context) => SignUp(),
        '/wrapper': (context) => Wrapper(),
      },
    );
  }
}
