import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'overview.dart';
import 'list.dart';
import 'settings.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Color activeColour = Theme.of(context).primaryColor;
    final Color inactiveColour = Theme.of(context).bottomAppBarColor;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 1.0,
        centerTitle: true,
        title: Text(
          'Work Towards',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 22.0,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
            color: Colors.black,
          )
        ],
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      bottomNavigationBar: Material(
        elevation: 7.0,
        color: Theme.of(context).backgroundColor,
        child: TabBar(
          controller: _tabController,
          indicatorColor: inactiveColour,
          unselectedLabelColor: Colors.black,
          labelColor: activeColour,
          tabs: <Widget>[
            Tab(
              icon: Icon(
                Icons.home,
                color:
                    _tabController.index == 0 ? activeColour : inactiveColour,
              ),
              text: 'Home',
            ),
            Tab(
              icon: Icon(
                Icons.filter_list,
                color:
                    _tabController.index == 1 ? activeColour : inactiveColour,
              ),
              text: 'Saved',
            ),
            Tab(
              icon: Icon(
                Icons.settings,
                color:
                    _tabController.index == 2 ? activeColour : inactiveColour,
              ),
              text: 'Settings',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          OverviewPage(),
          ListPage(),
          SettingsPage(),
        ],
      ),
    );
  }
}
