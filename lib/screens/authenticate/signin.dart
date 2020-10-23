import 'package:TodoApp/screens/authenticate/facebookSignIn.dart';
import 'package:TodoApp/screens/authenticate/googleSignIn.dart';
import 'package:TodoApp/screens/components/singinBackgroundPainter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      body: Stack(
        children: [
          SizedBox.expand(
            child: CustomPaint(
              painter: SigninBackgroundPainter(),
            ),
          ),
          Form(
            key: _signInKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 130,
                      right: 50,
                    ),
                    child: Text(
                      "Welcome\nBack",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.roboto(
                        fontSize: 60,
                        color: Colors.white,
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
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1.8,
                            color: Color(0xff092E34),
                          ),
                        ),
                        hintStyle: TextStyle(
                          color: Color(0xFF03AAC4),
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
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1.8,
                            color: Color(0xff092E34),
                          ),
                        ),
                        hintStyle: TextStyle(
                          color: Color(0xFF03AAC4),
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
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 5, left: 50),
                        child: Text(
                          "Sign in",
                          style: GoogleFonts.roboto(
                              fontSize: 40, color: Color(0xff092E34)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30, left: 50),
                        child: MaterialButton(
                          shape: CircleBorder(),
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ),
                          color: Color(0xff092E34),
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
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10, left:50),
                        child: RaisedButton(
                          hoverElevation: 0,
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                              color: Color(0xff092E34),
                            ),
                          ),
                          color: Colors.white,
                          onPressed: () {
                            widget.toggleView();
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, left: 80),
                        child: RaisedButton(
                          hoverElevation: 0,
                          child: Text(
                            "Forgot Password",
                            style: TextStyle(
                              color: Color(0xff092E34),
                            ),
                          ),
                          color: Colors.white,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  // Container(
                  //   margin: EdgeInsets.only(top: 30),
                  //   child: MaterialButton(
                  //     child: Text(
                  //       "SIGN IN",
                  //       style: TextStyle(
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //     color: Color(0xFF006655),
                  //     onPressed: () async {
                  //       dynamic resultOfSignIn =
                  //           await signIn(email.text, password.text);
                  //       if (resultOfSignIn == null) {
                  //         print("Sign In Failed !!!");
                  //         print(resultOfSignIn);
                  //       } else {
                  //         print("Sign In Successfull !!!");
                  //         print(resultOfSignIn);
                  //       }
                  //     },
                  //   ),
                  // ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 15, left: 35),
                        child: MaterialButton(
                          child: Text(
                            "Google",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          color: Color(0xff092E34),
                          onPressed: () async {
                            User user = await signInWithGoogle();
                            if (user.uid == null) {
                              print("Google Sign in Failed");
                            } else {
                              print("Google Sign in Successfull");
                            }
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15, right: 10, left: 10),
                        child: MaterialButton(
                          child: Text(
                            "Facebook",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          color: Color(0xff092E34),
                          onPressed: () async {
                            User user = await signInWithFacebook();
                            if (user.uid == null) {
                              print("Facebook Sign in Failed");
                            } else {
                              print("Facebook Sign in Successfull");
                            }
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        child: MaterialButton(
                          child: Text(
                            "Twitter",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          color: Color(0xff092E34),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
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
