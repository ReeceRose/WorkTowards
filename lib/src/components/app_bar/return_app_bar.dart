import 'package:WorkTowards/src/api/database_context.dart';
import 'package:flutter/material.dart';

import 'package:WorkTowards/main.dart';
import 'package:WorkTowards/src/bloc/calculator_bloc.dart';

class ReturnAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool editMode;
  final String itemId;
  final _calculatorBloc = getIt.get<CalculatorBloc>();

  ReturnAppBar({this.itemId = "", this.editMode = false});

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
      actions: _buildActions(context),
      leading: IconButton(
        onPressed: () {
          _calculatorBloc.clear();
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios),
      ),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    return editMode == true
        ? [
            IconButton(
              onPressed: () {
                DatabaseContext.database.removeItem(itemId);

                Navigator.pop(context);
              },
              icon: Icon(Icons.delete),
            )
          ]
        : null;
  }

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}
