import 'package:TodoApp/screens/components/appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
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
      appBar: CustomAppBar(),
      body: Form(
        key: _signUpKey,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 120, left: 50, right: 50),
              child: TextFormField(
                controller: email,
                decoration: InputDecoration(
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
                color: Colors.blue,
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
