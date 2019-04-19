import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 250.0,
            alignment: Alignment(0, 1),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/logo.png'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
