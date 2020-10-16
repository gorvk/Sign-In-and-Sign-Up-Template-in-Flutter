import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;
  SignUp({this.toggleView});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _signUpKey = GlobalKey<FormState>();
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
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 272),
            child: FlatButton.icon(
              textColor: Color(0xFF006655),
              icon: Icon(Icons.arrow_back),
              label: Text(
                "",
              ),
              onPressed: () {
                widget.toggleView();
              },
            ),
          )
        ],
      ),
      body: Form(
        key: _signUpKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 100),
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
                margin: EdgeInsets.only(top: 50, left: 50, right: 50),
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
                    "SIGN UP",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: Color(0xFF006655),
                  onPressed: () async {
                    dynamic resultOfSignUp =
                        await signUp(email.text, password.text);
                    if (resultOfSignUp == null) {
                      print("Sign Up Failed !!!");
                      print(resultOfSignUp);
                    } else {
                      print("Sign Up Successfull !!!");
                      print(resultOfSignUp);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<UserCredential> signUp(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        print("Password is weak, Please enter a strong password");
      } else if (e.code == "email-already-in-use") {
        print("Email is already registered");
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
