import 'package:TodoApp/screens/authenticate/signin.dart';
import 'package:flutter/material.dart';

class Portal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 150),
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
              SignIn(),
              Container(
                margin: EdgeInsets.only(top: 10, left: 100, right: 100),
                child: MaterialButton(
                  padding: EdgeInsets.all(10),
                  color: Color(0xFF006655),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                      ),
                      Icon(
                        Icons.account_circle,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                      ),
                      Text(
                        'Create Accout',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
