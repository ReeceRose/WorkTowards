import 'package:flutter/material.dart';

import 'package:flutter_circular_chart/flutter_circular_chart.dart';

import 'package:WorkTowards/src/api/database_context.dart';

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DatabaseContext.database.getAllItems(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<Map<dynamic, dynamic>> items = snapshot.data;
        if (items == null) {
          return Container();
        } else {
          return ListView.builder(
            itemCount: items.length == null ? 0 : items.length,
            itemBuilder: (BuildContext context, int index) {
              Map<dynamic, dynamic> item = items.elementAt(index);
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                    child: _buildChart(title: item["title"], context: context),
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }

  Container _buildChart(
      {double completed = 33.33,
      Color completedColour = Colors.blue,
      Color remainingColour = Colors.blueGrey,
      String title = "",
      BuildContext context}) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final GlobalKey<AnimatedCircularChartState> _chartKey =
        new GlobalKey<AnimatedCircularChartState>();
    return Container(
      width: deviceWidth / 2.5,
      height: deviceWidth / 2.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
        border: Border.all(color: Colors.grey.shade500),
      ),
      child: Column(
        children: <Widget>[
          AnimatedCircularChart(
            key: _chartKey,
            size: Size(deviceWidth / 3, deviceWidth / 3),
            initialChartData: <CircularStackEntry>[
              new CircularStackEntry(
                <CircularSegmentEntry>[
                  new CircularSegmentEntry(
                    completed,
                    completedColour,
                    rankKey: 'completed',
                  ),
                  new CircularSegmentEntry(
                    100 - completed,
                    remainingColour,
                    rankKey: 'remaining',
                  ),
                ],
                rankKey: 'progress',
              ),
            ],
            duration: Duration(milliseconds: 1252),
            holeLabel: '${completed.toStringAsPrecision(4)}%',
            chartType: CircularChartType.Radial,
            edgeStyle: SegmentEdgeStyle.round,
            percentageValues: true,
          ),
          Text(title),
        ],
      ),
    );
  }
}
