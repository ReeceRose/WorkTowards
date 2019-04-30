import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

// import 'package:flutter_circular_chart/flutter_circular_chart.dart';

class OverviewPage extends StatefulWidget {
  bool includeTax = true;
  double hourlyRate = 20.0;
  double itemPrice = 0.0;
  double taxRate = 1;
  double calculatedPrice = 0.0;
  String hoursNeeded = '0.0';

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
            style: Theme.of(context).textTheme.title,
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
                // Note: this text field will be auto populated by the hourly rate set in the settings
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Hourly Rate',
                    hintText: '20',
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(),
                    ),
                  ),
                  controller:
                      TextEditingController(text: widget.hourlyRate.toString()),
                  enabled: false,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Enter Price',
                    hintText: '200',
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
                        if (value.isEmpty) value = '0';
                        widget.itemPrice = double.parse(value);
                        _calculate();
                      },
                    );
                  },
                  keyboardType: TextInputType.number,
                ),
                Visibility(
                  visible: widget.includeTax,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Enter Tax Rate',
                          hintText: '13',
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
                              if (value.isEmpty) value = '0';
                              // this will give us a number like 1.XX
                              widget.taxRate = (double.parse(value) / 100) + 1;
                            },
                          );
                          _calculate();
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
                      value: widget.includeTax,
                      onChanged: (value) {
                        setState(
                          () {
                            widget.includeTax = value;
                            // reset the _taxRate
                            if (!widget.includeTax) widget.taxRate = 1;
                          },
                        );
                        _calculate();
                      },
                      activeColor: Colors.blue,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Total'),
                    Text('\$${widget.calculatedPrice}'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Hours Needed'),
                    Text('${widget.hoursNeeded}'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _calculate() {
    setState(
      () {
        widget.calculatedPrice = double.parse(
            (widget.itemPrice * (widget.includeTax ? widget.taxRate : 1))
                .toStringAsPrecision(5));
        widget.hoursNeeded =
            (widget.calculatedPrice / widget.hourlyRate).toStringAsPrecision(2);
      },
    );
  }
}
