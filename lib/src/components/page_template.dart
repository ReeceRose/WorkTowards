import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:WorkTowards/src/components/app_bar/main_app_bar.dart';
import 'package:WorkTowards/src/components/app_bar/main_bottom_navigation_bar.dart';

class PageTemplate extends StatelessWidget {
  Widget body = Container();
  TabController tabController;

  PageTemplate({this.body, this.tabController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: MainAppBar(),
      body: body,
      bottomNavigationBar: MainBottomNavigationBar(
        tabController: tabController,
      ),
    );
  }
}
