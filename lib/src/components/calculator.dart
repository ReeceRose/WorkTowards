import 'package:WorkTowards/src/api/database_context.dart';
import 'package:WorkTowards/src/model/item.dart';
import 'package:flutter/material.dart';

import 'package:WorkTowards/main.dart';
import 'package:WorkTowards/src/bloc/calculator_bloc.dart';

import 'package:WorkTowards/src/components/input/number_input.dart';
import 'package:flutter/widgets.dart';
import 'package:WorkTowards/src/components/input/text_input.dart';

class Calculator extends StatelessWidget {
  bool includeTitleInput;
  bool includeSubmitButton;
  bool editMode = true;
  String itemId;

  String title;

  final _calculatorBloc = getIt.get<CalculatorBloc>();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _taxRateController = TextEditingController();
  Calculator(
      {this.includeTitleInput = false,
      this.includeSubmitButton = false,
      this.editMode,
      this.itemId}) {
    String currentPrice = _calculatorBloc.currentPrice.toString();

    _titleController.text = _calculatorBloc.currentTitle;

    _titleController.addListener(() {
      title = _titleController.text;
      _calculatorBloc.currentTitle = title;
    });

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
    return Container(
      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
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
              controller: TextEditingController(text: '20'),
              enabled: false,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
            ),
            _buildTitleInput(),
            _buildPriceInputWithStream(),
            _buildIncludeTaxSwitchWithStream(),
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
            _buildSubmitButton(context),
          ],
        ),
      ),
    );
  }

  void _submit(BuildContext context) async {
    Item item = Item(
      title: _titleController.text,
      price: double.parse(_priceController.text),
      taxRate: double.parse(_taxRateController.text) ?? 0,
      includeTax: _calculatorBloc.includeTax,
    );
    // Clear state
    _calculatorBloc.clear();
    if (editMode) {
      await DatabaseContext.database.updateItem(id: itemId, item: item);
    } else {
      await DatabaseContext.database.insertItem(item);
    }
    Navigator.pop(context);
  }

  Visibility _buildTitleInput() {
    return Visibility(
      visible: includeTitleInput,
      child: StreamBuilder(
        stream: _calculatorBloc.titleStream$,
        builder: (BuildContext context, AsyncSnapshot snap) {
          return Container(
            padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: TextInput(
              label: 'Enter Item Name',
              hint: 'Xbox One',
              controller: _titleController,
            ),
          );
        },
      ),
    );
  }

  StreamBuilder _buildPriceInputWithStream() {
    return StreamBuilder(
      stream: _calculatorBloc.priceStream$,
      builder: (BuildContext context, AsyncSnapshot snap) {
        return Container(
          padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
          child: NumberInput(
            label: 'Enter Price',
            hint: '200',
            controller: _priceController,
          ),
        );
      },
    );
  }

  StreamBuilder _buildIncludeTaxSwitchWithStream() {
    return StreamBuilder(
      stream: _calculatorBloc.includeTaxStream$,
      builder: (BuildContext context, AsyncSnapshot snap) {
        return Visibility(
          visible: _calculatorBloc.includeTax,
          child: Container(
            padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: StreamBuilder(
              stream: _calculatorBloc.taxRateStream$,
              builder: (BuildContext context, AsyncSnapshot snap) {
                return NumberInput(
                  label: 'Enter Tax Rate',
                  hint: '13',
                  controller: _taxRateController,
                );
              },
            ),
          ),
        );
      },
    );
  }

  Visibility _buildSubmitButton(BuildContext context) {
    return Visibility(
      visible: includeSubmitButton,
      child: RaisedButton(
        onPressed: () => _submit(context),
        child: Text(
          editMode == true ? 'Edit' : 'Add',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
