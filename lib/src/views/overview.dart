import 'package:flutter/material.dart';

import 'package:WorkTowards/src/components/calculator.dart';

// import 'package:flutter_circular_chart/flutter_circular_chart.dart';

class OverviewPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
          child: Text(
            'Quick Calculate',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.title,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
          ),
          child: Calculator(),
        ),
      ],
    );
  }
}
