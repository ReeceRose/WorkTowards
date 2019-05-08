import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:WorkTowards/src/components/page_template.dart';
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
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      tabController: _tabController,
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[OverviewPage(), ListPage(), SettingsPage()],
      ),
    );
  }
}
