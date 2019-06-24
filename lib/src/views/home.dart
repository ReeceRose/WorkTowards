import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:WorkTowards/src/components/app_bar/main_app_bar.dart';
import 'package:WorkTowards/src/components/app_bar/main_bottom_navigation_bar.dart';

import 'package:WorkTowards/src/views/overview.dart';
import 'package:WorkTowards/src/views/list.dart';
import 'package:WorkTowards/src/views/settings.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: MainAppBar(),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[OverviewPage(), ListPage(), SettingsPage()],
      ),
      bottomNavigationBar: MainBottomNavigationBar(
        tabController: _tabController,
      ),
    );
  }
}
