import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _includeTax = true;
  double _itemPrice = 0.0;
  double _taxRate = 1.13;
  double _calculatedPrice = 0.0;
  @override
  Widget build(BuildContext context) {
    double inputWidth = MediaQuery.of(context).size.width / 1.25;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Work Towards',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Bungee',
          ),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
            icon: Icon(Icons.settings),
            color: Colors.black,
          ),
        ],
      ),
      body: Center(
        child: Container(
          width: inputWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 15.0,
              ),
              Container(
                width: inputWidth,
                child: TextField(
                  decoration: InputDecoration(
                    labelStyle: TextStyle(fontFamily: 'Bungee'),
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
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                ),
              ),
              Visibility(
                visible: _includeTax,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      width: inputWidth,
                      child: TextField(
                        decoration: InputDecoration(
                          labelStyle: TextStyle(fontFamily: 'Bungee'),
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
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: inputWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Include Tax?'),
                    Switch(
                      value: _includeTax,
                      onChanged: (value) {
                        setState(
                          () {
                            _includeTax = value;
                          },
                        );
                        _calculateTax();
                      },
                      activeColor: Colors.blue,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text('Total'), Text("\$$_calculatedPrice")],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _calculateTax() {
    setState(
      () {
        print(_itemPrice);
        _calculatedPrice = (_itemPrice * (_includeTax ? _taxRate : 1)).roundToDouble();
      },
    );
  }
}
