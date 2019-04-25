import 'package:flutter/material.dart';

// import 'package:flutter_circular_chart/flutter_circular_chart.dart';

class OverviewPage extends StatefulWidget {
  bool includeTax = true;
  double itemPrice = 0.0;
  double taxRate = 1;
  double calculatedPrice = 0.0;

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
                        widget.itemPrice = double.parse(value);
                        _calculateTax();
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
                              widget.taxRate = (double.parse(value) / 100) + 1;
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
                      value: widget.includeTax,
                      onChanged: (value) {
                        setState(
                          () {
                            widget.includeTax = value;
                            // reset the _taxRate
                            if (!widget.includeTax) widget.taxRate = 1;
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
                    Text('\$${widget.calculatedPrice}'),
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
        widget.calculatedPrice = double.parse(
            (widget.itemPrice * (widget.includeTax ? widget.taxRate : 1))
                .toStringAsPrecision(5));
      },
    );
  }
}
