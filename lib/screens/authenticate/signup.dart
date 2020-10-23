import 'package:TodoApp/screens/authenticate/facebookSignIn.dart';
import 'package:TodoApp/screens/authenticate/googleSignIn.dart';
import 'package:TodoApp/screens/components/signupBackgroundPainter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      body: Stack(
        children: [
          SizedBox.expand(
            child: CustomPaint(
              painter: SignupBackgroundPainter(),
            ),
          ),
          Form(
            key: _signUpKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 80, right: 100),
                    child: Text(
                      "Create\nAccount",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.roboto(
                        fontSize: 60,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50, left: 50, right: 50),
                    child: TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x70FFFFFF),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1.8,
                            color: Color(0xADFFFFFF),
                          ),
                        ),
                        hintStyle: TextStyle(
                          color: Color(0xADFFFFFF),
                        ),
                        hintText: "Name",
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
                      controller: email,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x70FFFFFF),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1.8,
                            color: Color(0xADFFFFFF),
                          ),
                        ),
                        hintStyle: TextStyle(
                          color: Color(0xADFFFFFF),
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
                            color: Color(0x70FFFFFF),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1.8,
                            color: Color(0xADFFFFFF),
                          ),
                        ),
                        hintStyle: TextStyle(
                          color: Color(0xADFFFFFF),
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
                        margin: EdgeInsets.only(top: 10, left: 50),
                        child: Text(
                          "Sign up",
                          style: GoogleFonts.roboto(
                              fontSize: 40, color: Colors.white),
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
                      ),
                    ],
                  ),
                  Container(
                        margin: EdgeInsets.only(top: 10, right:150),
                        child: RaisedButton(
                          hoverElevation: 0,
                          child: Text(
                            "Sign In",
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
