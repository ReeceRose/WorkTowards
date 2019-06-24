import 'package:flutter/material.dart';

class MainBottomNavigationBar extends StatelessWidget {
  TabController tabController;

  MainBottomNavigationBar({this.tabController});

  @override
  Widget build(BuildContext context) {
    final Color activeColour = Theme.of(context).primaryColor;
    final Color inactiveColour = Theme.of(context).bottomAppBarColor;
    return Material(
      elevation: 7.0,
      color: Theme.of(context).backgroundColor,
      child: TabBar(
        controller: tabController,
        indicatorColor: inactiveColour,
        unselectedLabelColor: Colors.black,
        labelColor: activeColour,
        tabs: <Widget>[
          Tab(
            icon: Icon(
              Icons.home,
              color: tabController.index == 0 ? activeColour : inactiveColour,
            ),
          ),
          Tab(
            icon: Icon(
              Icons.filter_list,
              color: tabController.index == 1 ? activeColour : inactiveColour,
            ),
          ),
          Tab(
            icon: Icon(
              Icons.settings,
              color: tabController.index == 2 ? activeColour : inactiveColour,
            ),
          ),
        ],
      ),
    );
  }
}
