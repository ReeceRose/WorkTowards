import 'package:flutter/material.dart';

import 'package:WorkTowards/src/components/app_bar/return_app_bar.dart';

class AddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReturnAppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[Text('Add')],
        ),
      ),
    );
  }
}
