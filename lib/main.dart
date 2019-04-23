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
            subtitle: TextStyle(fontSize: 20.0),
          ),
        ),
        home: HomePage(),
      ),
    );
