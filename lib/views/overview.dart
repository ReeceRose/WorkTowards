import 'package:flutter/material.dart';

import 'package:flutter_circular_chart/flutter_circular_chart.dart';

class OverviewPage extends StatefulWidget {
  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  bool _includeTax = true;
  double _itemPrice = 0.0;
  double _taxRate = 1.13;
  double _calculatedPrice = 0.0;

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
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
        ),
        Container(
          // width: containerWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.grey.shade50,
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Enter Price',
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(),
                    ),
                  ),
                  onChanged: (value) {
                    setState(
                      () {
                        _itemPrice = double.parse(value);
                      },
                    );
                    _calculateTax();
                  },
                  keyboardType: TextInputType.number,
                ),
                Visibility(
                  visible: _includeTax,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Enter Tax Rate',
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(),
                          ),
                        ),
                        onChanged: (value) {
                          setState(
                            () {
                              // this will give us a number like 1.XX
                              _taxRate = (double.parse(value) / 100) + 1;
                            },
                          );
                          _calculateTax();
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text('Include Tax?'),
                    Switch(
                      value: _includeTax,
                      onChanged: (value) {
                        setState(
                          () {
                            _includeTax = value;
                            // reset the _taxRate
                            if (!_includeTax) _taxRate = 1;
                          },
                        );
                        _calculateTax();
                      },
                      activeColor: Colors.blue,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Total'),
                    Text('\$$_calculatedPrice'),
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
          child: Text(
            'Saved Items',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.grey.shade50,
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _buildChart(title: 'Item One', completed: 15.0),
                    _buildChart(title: 'Item Two', completed: 100.0),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _calculateTax() {
    setState(
      () {
        _calculatedPrice = double.parse(
            (_itemPrice * (_includeTax ? _taxRate : 1)).toStringAsPrecision(4));
      },
    );
  }

  Container _buildChart(
      {double completed = 33.33,
      Color completedColour = Colors.blue,
      Color remainingColour = Colors.blueGrey,
      String title = ""}) {
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
          border: Border.all(color: Colors.grey.shade500)),
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
            holeLabel: '${completed.toStringAsPrecision(4)}%',
            chartType: CircularChartType.Radial,
            edgeStyle: SegmentEdgeStyle.round,
            percentageValues: true,
          ),
          Text(title)
        ],
      ),
    );
  }
}
