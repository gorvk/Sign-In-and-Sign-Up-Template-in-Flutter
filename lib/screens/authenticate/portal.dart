import 'package:TodoApp/screens/authenticate/signin.dart';
import 'package:TodoApp/screens/authenticate/signup.dart';
import 'package:flutter/material.dart';

class Portal extends StatefulWidget {
  @override
  _PortalState createState() => _PortalState();
}

class _PortalState extends State<Portal> {
  bool showSignIn = true;
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn == true) {
      return SignIn(toggleView: toggleView);
    }
    return SignUp(toggleView: toggleView);
  }
}
