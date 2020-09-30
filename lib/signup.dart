import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Todo App",
            style: TextStyle(fontSize: 35, fontFamily: "Cursive"),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          child: Column(
            children: <Widget>[
              Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 35,
                  fontFamily: "Cursive",
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 30)),
              TextField(
                controller: email,
                decoration: InputDecoration(hintText: "Email"),
              ),
              Padding(padding: EdgeInsets.only(bottom: 10)),
              TextField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(hintText: "Password"),
              ),
              Padding(padding: EdgeInsets.only(bottom: 30)),
              MaterialButton(
                color: Colors.blue,
                child: Center(
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Cursive"),
                  ),
                ),
                onPressed: () async {
                  UserCredential userCredential = await register();
                  if (userCredential == null) {
                    print("Sign Up failed !!!");
                  } else {
                    print("Sign Up Successfull");
                    print(userCredential);
                  }
                },
              ),
            ],
          ),
          padding: EdgeInsets.fromLTRB(50, 130, 50, 100),
        ),
      ),
    );
  }

  Future<UserCredential> register() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print("Password provided is weak");
      } else if (e.code == 'email-already-in-use') {
        print("Email already exist");
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
