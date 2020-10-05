import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  @override
  Size get preferredSize => Size.fromHeight(55);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Center(
        child: Text(
          "Todo App",
          style: TextStyle(
            fontFamily: "Cursive",
            fontSize: 40,
          ),
        ),
      ),
    );
  }
}