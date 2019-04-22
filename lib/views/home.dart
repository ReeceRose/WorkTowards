import 'package:flutter/material.dart';

import 'overview.dart';
import 'settings.dart';

class HomePage extends StatefulWidget {
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
        title: Image.asset(
          'assets/images/logo.png',
          width: 150,
          fit: BoxFit.cover,
        ),
        // title: Text(
        //   'Work Towards',
        //             style: TextStyle(
        //     color: Colors.black,
        //     fontFamily: 'Inconsolata',
        //     fontSize: 25.0,
        //   ),
        // ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
            color: Colors.black,
          )
        ],
        backgroundColor: Colors.white,
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
          Container(),
          SettingsPage(),
        ],
      ),
    );
  }
}
