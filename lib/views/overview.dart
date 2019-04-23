import 'package:flutter/material.dart';

import 'package:flutter_circular_chart/flutter_circular_chart.dart';

class OverviewPage extends StatefulWidget {
  bool _includeTax = true;
  double _itemPrice = 0.0;
  double _taxRate = 1;
  double _calculatedPrice = 0.0;
  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
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
            style: Theme.of(context).textTheme.subtitle,
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
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Enter Price',
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(),
                    ),
                  ),
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    setState(
                      () {
                        widget._itemPrice = double.parse(value);
                      },
                    );
                    _calculateTax();
                  },
                  keyboardType: TextInputType.number,
                ),
                Visibility(
                  visible: widget._includeTax,
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
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          setState(
                            () {
                              // this will give us a number like 1.XX
                              widget._taxRate = (double.parse(value) / 100) + 1;
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
                      value: widget._includeTax,
                      onChanged: (value) {
                        setState(
                          () {
                            widget._includeTax = value;
                            // reset the _taxRate
                            if (!widget._includeTax) widget._taxRate = 1;
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
                    Text('\$${widget._calculatedPrice}'),
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
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle,
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
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          _buildChart(title: 'Item One', completed: 25.0),
                          _buildChart(title: 'Item Two', completed: 100.0),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          _buildChart(title: 'Item One', completed: 25.0),
                          _buildChart(title: 'Item Two', completed: 100.0),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          _buildChart(title: 'Item One', completed: 25.0),
                          _buildChart(title: 'Item Two', completed: 100.0),
                        ],
                      ),
                    ),
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
        widget._calculatedPrice = double.parse(
            (widget._itemPrice * (widget._includeTax ? widget._taxRate : 1))
                .toStringAsPrecision(4));
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
            duration: Duration(milliseconds: 1250),
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