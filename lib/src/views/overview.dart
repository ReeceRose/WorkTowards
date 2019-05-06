import 'package:WorkTowards/main.dart';
import 'package:WorkTowards/src/bloc/calculator_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

// import 'package:flutter_circular_chart/flutter_circular_chart.dart';

class OverviewPage extends StatelessWidget {
  final _calculatorBloc = getIt.get<CalculatorBloc>();
  final _priceController = TextEditingController();
  final _taxRateController = TextEditingController();

  OverviewPage() {
    String currentPrice = _calculatorBloc.currentPrice.toString();
    // this will leave the field empty and not 0.0 if a value isn't set
    _priceController.text = currentPrice == '0.0' ? '' : currentPrice.replaceAll('.0', '');
    _priceController.addListener(() {
      String value = _priceController.text;
      if (value.isEmpty) value = '0';
      // snap.data
      _calculatorBloc.currentPrice = double.parse(value);
    });

    // this will leave the field empty and not 1.0 if a value isn't set
    String taxRate = _calculatorBloc.currentTaxRate.toString();
    _taxRateController.text = taxRate == '0.0' ? '' : taxRate.replaceAll('.0', '');
    _taxRateController.addListener(() {
      String value = _taxRateController.text;
      if (value.isEmpty) value = '0';
      _calculatorBloc.currentTaxRate = double.parse(value);
    });
  }

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
                      TextEditingController(text: '20'),
                  enabled: false,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 10,
                ),
                StreamBuilder(
                  stream: _calculatorBloc.priceStream$,
                  builder: (BuildContext context, AsyncSnapshot snap) {
                    return TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Enter Price',
                        hintText: '200',
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(),
                        ),
                      ),
                      controller: _priceController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                    );
                  },
                ),
                StreamBuilder(
                  stream: _calculatorBloc.includeTaxStream$,
                  builder: (BuildContext context, AsyncSnapshot snap) {
                    return Visibility(
                      visible: _calculatorBloc.includeTax,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 10.0,
                          ),
                          StreamBuilder(
                            stream: _calculatorBloc.taxRateStream$,
                            builder:
                                (BuildContext context, AsyncSnapshot snap) {
                              return TextFormField(
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
                                controller: _taxRateController,
                                keyboardType: TextInputType.number,
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
                StreamBuilder(
                  stream: _calculatorBloc.includeTaxStream$,
                  initialData: true,
                  builder: (BuildContext context, AsyncSnapshot snap) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text('Include Tax?'),
                        Switch(
                          value: snap.data,
                          onChanged: (value) {
                            _calculatorBloc.includeTax = value;
                          },
                          activeColor: Colors.blue,
                        ),
                      ],
                    );
                  },
                ),
                StreamBuilder(
                  stream: _calculatorBloc.calculatedPriceStream$,
                  builder: (BuildContext context, AsyncSnapshot snap) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Total'),
                        Text('\$${snap.data}'),
                      ],
                    );
                  },
                ),
                StreamBuilder(
                  stream: _calculatorBloc.hoursNeededStream$,
                  builder: (BuildContext context, AsyncSnapshot snap) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Hours Needed'),
                        Text('${snap.data}'),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
