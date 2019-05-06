import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'src/bloc/calculator_bloc.dart';

import 'src/views/home.dart';



GetIt getIt = GetIt();

void main() {
  getIt.registerSingleton<CalculatorBloc>(CalculatorBloc());
  runApp(
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
}
