import 'package:flutter/material.dart';

import 'overview.dart';
import 'list.dart';
import 'settings.dart';

class HomePage extends StatefulWidget {
  bool includeTax = true;
  double itemPrice = 0.0;
  double taxRate = 1;
  double calculatedPrice = 0.0;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.5,
        centerTitle: true,
        title: Text(
          'Work Towards',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            // fontFamily: 'Inconsolata',
            fontSize: 22.0,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
          )
        ],
      ),
      bottomNavigationBar: Material(
        color: Colors.white,
        child: TabBar(
          controller: tabController,
          indicatorColor: Colors.grey.shade100,
          labelColor: Colors.blue,
          tabs: <Widget>[
            Tab(
              icon: Icon(
                Icons.home,
                color: Colors.grey.shade400,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.filter_list,
                color: Colors.grey.shade400,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.settings,
                color: Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          OverviewPage(),
          ListPage(),
          SettingsPage(),
        ],
      ),
    );
  }
}
