import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
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
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      body: Form(
        key: _signInKey,
        child: Column(
          children: <Widget>[
            TextFormField(
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
            TextFormField(
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
            MaterialButton(
              child: Text("SIGN IN"),
              onPressed: () async {
                dynamic resultOfSignIn = await signIn(email.text, password.text);
                if(resultOfSignIn == null){
                  print("Sign In Failed !!!");
                  print(resultOfSignIn);
                }else{
                  print("Sign In Successfull !!!");
                  print(resultOfSignIn);
                }
              },
            )
          ],
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
