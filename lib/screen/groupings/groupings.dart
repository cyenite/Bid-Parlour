import 'package:bid_parlour/screen/groupings/tabs/group_tab.dart';
import 'package:flutter/material.dart';

class Groupings extends StatefulWidget {
  final Widget child;

  Groupings({Key key, this.child}) : super(key: key);

  _GroupingsState createState() => _GroupingsState();
}

class _GroupingsState extends State<Groupings>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 4, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        centerTitle: true,
        title: Text(
          "Groupings",
          style: TextStyle(
              fontFamily: "Gotik", fontWeight: FontWeight.w600, fontSize: 18.5),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.search,
            ),
          ),
        ],
        elevation: 3.0,
        backgroundColor: Theme.of(context).canvasColor,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Theme.of(context).accentColor,
          labelColor: Theme.of(context).accentColor,
          tabs: <Widget>[
            new Tab(
              child: Text(
                "10s",
                style: TextStyle(fontFamily: "Popins"),
              ),
            ),
            new Tab(
              child: Text(
                "20s",
                style: TextStyle(fontFamily: "Popins"),
              ),
            ),
            new Tab(
              child: Text(
                "30s",
                style: TextStyle(fontFamily: "Popins"),
              ),
            ),
            new Tab(
              child: Text(
                "40s",
                style: TextStyle(fontFamily: "Popins"),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          GroupTab(type: "10s"),
          GroupTab(type: "20s"),
          GroupTab(type: "30s"),
          GroupTab(type: "40s")
        ],
        controller: _tabController,
      ),
    );
  }
}
