import 'package:flutter/material.dart';

import 'views/home.dart';

void main() => runApp(
      MaterialApp(
        title: 'Work Towards',
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Montserrat',
          textTheme: TextTheme(
            title: TextStyle(fontSize: 20.0),
            body1: TextStyle(fontSize: 14.0),
          ),
        ),
        home: HomePage(),
      ),
    );
