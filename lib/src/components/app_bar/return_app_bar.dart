import 'package:flutter/material.dart';

import 'package:WorkTowards/main.dart';
import 'package:WorkTowards/src/bloc/calculator_bloc.dart';

class ReturnAppBar extends StatelessWidget implements PreferredSizeWidget {
  final _calculatorBloc = getIt.get<CalculatorBloc>();
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1.0,
      centerTitle: true,
      title: Text(
        'Work Towards',
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 22.0,
        ),
      ),
      leading: IconButton(
        onPressed: () {
          _calculatorBloc.clear();
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios),
      ),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}
