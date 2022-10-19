import 'package:bid_parlour/component/style.dart';
import 'package:bid_parlour/screen/groupings/tabs/group_tab.dart';
import 'package:flutter/material.dart';

import '../../widgets/gradient_text.dart';

class Groupings extends StatefulWidget {
  final Widget child;

  Groupings({Key key, this.child}) : super(key: key);

  _GroupingsState createState() => _GroupingsState();
}

class _GroupingsState extends State<Groupings>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  String _value = 'Level 1';

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
            child: Theme(
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  dropdownColor: colorStyle.background,
                  value: _value,
                  items: <DropdownMenuItem<String>>[
                    DropdownMenuItem(
                      child: GradientText(
                        'Level 1',
                        gradient: LinearGradient(colors: [
                          Colors.blue.shade400,
                          Colors.green.shade400,
                        ]),
                      ),
                      value: "Level 1",
                    ),
                    DropdownMenuItem(
                      child: GradientText(
                        'Level 2',
                        gradient: LinearGradient(colors: [
                          Colors.blue.shade400,
                          Colors.green.shade400,
                        ]),
                      ),
                      value: "Level 2",
                    ),
                    DropdownMenuItem(
                      child: GradientText(
                        'Level 3',
                        gradient: LinearGradient(colors: [
                          Colors.blue.shade400,
                          Colors.green.shade400,
                        ]),
                      ),
                      value: "Level 3",
                    ),
                    DropdownMenuItem(
                      child: GradientText(
                        'Level 4',
                        gradient: LinearGradient(colors: [
                          Colors.blue.shade400,
                          Colors.green.shade400,
                        ]),
                      ),
                      value: "Level 4",
                    ),
                  ],
                  onChanged: (String value) {
                    setState(() => _value = value);
                  },
                ),
              ),
              data: new ThemeData.dark(),
            ),
          ),
        ],
        elevation: 3.0,
        backgroundColor: Theme.of(context).canvasColor,
        bottom: _value == 'Level 1'
            ? level1Tab()
            : _value == 'Level 2'
                ? level2Tab()
                : _value == 'Level 3'
                    ? level3Tab()
                    : _value == 'Level 4'
                        ? level4Tab()
                        : level1Tab(),
      ),
      body: _value == 'Level 1'
          ? level1TabView()
          : _value == 'Level 2'
              ? level2TabView()
              : _value == 'Level 3'
                  ? level3TabView()
                  : _value == 'Level 4'
                      ? level4TabView()
                      : level1TabView(),
    );
  }

  Widget level1Tab() {
    return TabBar(
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
    );
  }

  Widget level2Tab() {
    return TabBar(
      controller: _tabController,
      indicatorColor: Theme.of(context).accentColor,
      labelColor: Theme.of(context).accentColor,
      tabs: <Widget>[
        new Tab(
          child: Text(
            "50s",
            style: TextStyle(fontFamily: "Popins"),
          ),
        ),
        new Tab(
          child: Text(
            "100s",
            style: TextStyle(fontFamily: "Popins"),
          ),
        ),
        new Tab(
          child: Text(
            "150s",
            style: TextStyle(fontFamily: "Popins"),
          ),
        ),
        new Tab(
          child: Text(
            "200s",
            style: TextStyle(fontFamily: "Popins"),
          ),
        ),
      ],
    );
  }

  Widget level3Tab() {
    return TabBar(
      controller: _tabController,
      indicatorColor: Theme.of(context).accentColor,
      labelColor: Theme.of(context).accentColor,
      tabs: <Widget>[
        new Tab(
          child: Text(
            "100s",
            style: TextStyle(fontFamily: "Popins"),
          ),
        ),
        new Tab(
          child: Text(
            "200s",
            style: TextStyle(fontFamily: "Popins"),
          ),
        ),
        new Tab(
          child: Text(
            "300s",
            style: TextStyle(fontFamily: "Popins"),
          ),
        ),
        new Tab(
          child: Text(
            "400s",
            style: TextStyle(fontFamily: "Popins"),
          ),
        ),
      ],
    );
  }

  Widget level4Tab() {
    return TabBar(
      controller: _tabController,
      indicatorColor: Theme.of(context).accentColor,
      labelColor: Theme.of(context).accentColor,
      tabs: <Widget>[
        new Tab(
          child: Text(
            "500s",
            style: TextStyle(fontFamily: "Popins"),
          ),
        ),
        new Tab(
          child: Text(
            "1000s",
            style: TextStyle(fontFamily: "Popins"),
          ),
        ),
        new Tab(
          child: Text(
            "1500s",
            style: TextStyle(fontFamily: "Popins"),
          ),
        ),
        new Tab(
          child: Text(
            "2000s",
            style: TextStyle(fontFamily: "Popins"),
          ),
        ),
      ],
    );
  }

  Widget level1TabView() {
    return TabBarView(
      children: <Widget>[
        GroupTab(type: "10s"),
        GroupTab(type: "20s"),
        GroupTab(type: "30s"),
        GroupTab(type: "40s")
      ],
      controller: _tabController,
    );
  }

  Widget level2TabView() {
    return TabBarView(
      children: <Widget>[
        GroupTab(type: "50s"),
        GroupTab(type: "100s"),
        GroupTab(type: "150s"),
        GroupTab(type: "200s")
      ],
      controller: _tabController,
    );
  }

  Widget level3TabView() {
    return TabBarView(
      children: <Widget>[
        GroupTab(type: "100s"),
        GroupTab(type: "200s"),
        GroupTab(type: "300s"),
        GroupTab(type: "400s")
      ],
      controller: _tabController,
    );
  }

  Widget level4TabView() {
    return TabBarView(
      children: <Widget>[
        GroupTab(type: "500s"),
        GroupTab(type: "1000s"),
        GroupTab(type: "1500s"),
        GroupTab(type: "2000s")
      ],
      controller: _tabController,
    );
  }
}
