import 'package:WorkTowards/src/views/details.dart';
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
          return _buildListView(context: context, items: items);
        }
      },
    );
  }

  void _openDetailsPage(BuildContext context, String id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsPage(
              itemId: id,
            ),
      ),
    );
  }

  ListView _buildListView(
      {BuildContext context, List<Map<dynamic, dynamic>> items}) {
    List<Widget> children = List<Widget>();
    for (var i = 0; i <= items.length - 1; i += 2) {
      var item = items.elementAt(i);
      List<Widget> rowItems = List<Widget>();
      rowItems.add(
        InkWell(
          onTap: () => _openDetailsPage(context, item["_id"]),
          child: _buildChart(
            context: context,
            title: item["title"],
          ),
        ),
      );
      try {
        var secondItem = items.elementAt(i + 1);
        rowItems.add(
          InkWell(
            onTap: () => _openDetailsPage(context, secondItem["_id"]),
            child: _buildChart(
              context: context,
              title: secondItem["title"],
            ),
          ),
        );
      } catch (_) {
        // rowItems.add(Container());
      }
      children.add(
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.grey.shade50,
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: rowItems,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
    return ListView(
      children: children,
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
      width: deviceWidth / 2.1,
      height: deviceWidth / 2.1,
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
