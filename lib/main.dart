import 'package:flutter/material.dart';

import 'views/home.dart';
import 'views/settings.dart';

void main() => runApp(
      MaterialApp(
        title: 'Work Towards',
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Montserrat'
        ),
        routes: {
          '/': (context) => HomePage(),
          '/settings': (context) => SettingsPage(),
        },
      ),
    );
