import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _signInKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Form(
        key: _signInKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 80),
                child: Text(
                  "Todo App",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Cursive",
                    color: Color(0xFF006655),
                    fontSize: 60,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 50,
                  left: 50,
                  right: 50,
                ),
                child: TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF006655),
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 1.8,
                        color: Color(0xFF006655),
                      ),
                    ),
                    hintStyle: TextStyle(
                      color: Color(0xFF006655),
                    ),
                    hintText: "Email",
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter your Email Address";
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15, left: 50, right: 50),
                child: TextFormField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF006655),
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 1.8,
                        color: Color(0xFF006655),
                      ),
                    ),
                    hintStyle: TextStyle(
                      color: Color(0xFF006655),
                    ),
                    hintText: "Password",
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter a Password";
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: MaterialButton(
                  child: Text(
                    "SIGN IN",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: Color(0xFF006655),
                  onPressed: () async {
                    dynamic resultOfSignIn =
                        await signIn(email.text, password.text);
                    if (resultOfSignIn == null) {
                      print("Sign In Failed !!!");
                      print(resultOfSignIn);
                    } else {
                      print("Sign In Successfull !!!");
                      print(resultOfSignIn);
                    }
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: MaterialButton(
                  child: Text(
                    "Create Account",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: Color(0xFF006655),
                  onPressed: () {
                    widget.toggleView();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<UserCredential> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return (userCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("No user found with that email");
      } else if (e.code == "wrong-password") {
        print("Wrong Password");
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
