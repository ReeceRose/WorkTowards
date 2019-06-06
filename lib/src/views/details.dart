import 'package:WorkTowards/src/api/database_context.dart';
import 'package:WorkTowards/src/components/app_bar/return_app_bar.dart';
import 'package:WorkTowards/src/components/calculator.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  String itemId;

  Future<List<Map<dynamic, dynamic>>> item;

  DetailsPage({this.itemId}) {
    item = DatabaseContext.database.getItemById(itemId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReturnAppBar(),
      body: FutureBuilder(
        future: item,
        builder: (BuildContext context, AsyncSnapshot snap) {
          return SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                child: Text(
                  'Edit item',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white,
                ),
                child: Calculator(
                  includeTitleInput: true,
                  includeSubmitButton: true,
                  editMode: true,
                ),
              ),
            ],
          ),
        ),
      ); 
          // Text(snap.data.toString());
        },
      ),
    );
  }
}
