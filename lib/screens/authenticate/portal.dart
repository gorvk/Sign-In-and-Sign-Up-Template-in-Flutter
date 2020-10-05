import 'package:TodoApp/screens/authenticate/signin.dart';
import 'package:TodoApp/screens/components/appbar.dart';
import 'package:flutter/material.dart';

class Portal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        child: Column(
          children: <Widget>[
            SignIn(),
            Container(
              margin: EdgeInsets.only(top: 10, left: 100, right: 100),
              child: MaterialButton(
                padding: EdgeInsets.all(10),
                color: Colors.blue,
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
    );
  }
}
