import 'package:flutter/material.dart';

import 'src/views/home.dart';

void main() => runApp(
      MaterialApp(
        title: 'Work Towards',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color.fromARGB(255, 34, 148, 240),
          backgroundColor: Colors.grey.shade50,
          bottomAppBarColor: Colors.grey.shade600,
          fontFamily: 'Montserrat',
          textTheme: TextTheme(
            title: TextStyle(
              fontSize: 18.0,
              color: Color.fromARGB(255, 6, 6, 6),
            ),
            body1: TextStyle(
              fontSize: 15.0,
              color: Color.fromARGB(255, 6, 6, 6),
            ),
          ),
        ),
        home: HomePage(),
      ),
    );
