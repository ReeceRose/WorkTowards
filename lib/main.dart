import 'package:flutter/material.dart';

import 'views/home.dart';

void main() => runApp(
      MaterialApp(
        title: 'Flutter UI',
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (context) => HomePage(),
        },
      ),
    );
