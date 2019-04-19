import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool includeTax = true;
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 15.0,
            ),
            Container(
              width: inputWidth,
              child: TextFormField(
                decoration: InputDecoration(
                  labelStyle: TextStyle(fontFamily: 'Bungee'),
                  labelText: 'Enter Price',
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(),
                  ),
                ),
                validator: (val) {
                  if (val.length == 0) {
                    return "Please enter a valid number";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.number,
              ),
            ),
            Visibility(
              visible: includeTax,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    width: inputWidth,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelStyle: TextStyle(fontFamily: 'Bungee'),
                        labelText: 'Enter Tax Rate',
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(),
                        ),
                      ),
                      validator: (val) {
                        if (val.length == 0) {
                          return "Please enter a valid tax rate";
                        } else {
                          return null;
                        }
                      },
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
                    value: includeTax,
                    onChanged: (value) {
                      setState(() {
                        includeTax = value;
                      });
                    },
                    activeColor: Colors.blue,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
