import 'package:flutter/material.dart';

import 'package:WorkTowards/main.dart';
import 'package:WorkTowards/src/bloc/calculator_bloc.dart';

import 'package:WorkTowards/src/components/input/number_input.dart';
// import 'package:WorkTowards/src/components/input/text_input.dart';

class Calculator extends StatelessWidget {
  final _calculatorBloc = getIt.get<CalculatorBloc>();
  final _priceController = TextEditingController();
  final _taxRateController = TextEditingController();

  Calculator() {
    String currentPrice = _calculatorBloc.currentPrice.toString();
    // this will leave the field empty and not 0.0 if a value isn't set
    _priceController.text =
        currentPrice == '0.0' ? '' : currentPrice.replaceAll('.0', '');
    _priceController.addListener(() {
      String value = _priceController.text;
      if (value.isEmpty) value = '0';
      // snap.data
      _calculatorBloc.currentPrice = double.parse(value);
    });

    // this will leave the field empty and not 1.0 if a value isn't set
    String taxRate = _calculatorBloc.currentTaxRate.toString();
    _taxRateController.text =
        taxRate == '0.0' ? '' : taxRate.replaceAll('.0', '');
    _taxRateController.addListener(() {
      String value = _taxRateController.text;
      if (value.isEmpty) value = '0';
      _calculatorBloc.currentTaxRate = double.parse(value);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
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
            controller: TextEditingController(text: '20'),
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
              return NumberInput(
                label: 'Enter Price',
                hint: '200',
                controller: _priceController,
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
                      builder: (BuildContext context, AsyncSnapshot snap) {
                        return NumberInput(
                          label: 'Enter Tax Rate',
                          hint: '13',
                          controller: _taxRateController,
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
    );
  }
}
