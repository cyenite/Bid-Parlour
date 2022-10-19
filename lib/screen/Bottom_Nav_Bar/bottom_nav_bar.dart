import 'package:bid_parlour/screen/Bottom_Nav_Bar/custom_nav_bar.dart';
import 'package:bid_parlour/screen/Home/Home.dart';
import 'package:bid_parlour/screen/announcements/announcement_home.dart';
import 'package:bid_parlour/screen/setting/setting.dart';
import 'package:bid_parlour/screen/setting/themes.dart';
import 'package:flutter/material.dart';

import '../groupings/groupings.dart';
import '../wallet/wallet.dart';

class BottomNavBar extends StatefulWidget {
  ThemeBloc themeBloc;
  BottomNavBar({this.themeBloc});

  _BottomNavBarState createState() => _BottomNavBarState(themeBloc);
}

class _BottomNavBarState extends State<BottomNavBar> {
  ThemeBloc _themeBloc;
  _BottomNavBarState(this._themeBloc);
  int currentIndex = 0;
  bool _color = true;
  Widget callPage(int current) {
    switch (current) {
      case 0:
        return new Home();
        break;
      case 1:
        return new Groupings();
        break;
      case 2:
        return new Wallet();
        break;
      case 3:
        return new Announcements();
        break;
      case 4:
        return new Settings(themeBloc: _themeBloc);
        break;
      default:
        return new Home();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: callPage(currentIndex),
      bottomNavigationBar: BottomNavigationDotBar(
          // Usar -> "BottomNavigationDotBar"
          color: Theme.of(context).hintColor,
          items: <BottomNavigationDotBarItem>[
            BottomNavigationDotBarItem(
                icon: Icons.home,
                onTap: () {
                  setState(() {
                    currentIndex = 0;
                  });
                }),
            BottomNavigationDotBarItem(
                icon: Icons.account_balance,
                onTap: () {
                  setState(() {
                    currentIndex = 1;
                  });
                }),
            BottomNavigationDotBarItem(
                icon: Icons.account_balance_wallet,
                onTap: () {
                  setState(() {
                    currentIndex = 2;
                  });
                }),
            BottomNavigationDotBarItem(
                icon: Icons.library_books,
                onTap: () {
                  setState(() {
                    currentIndex = 3;
                  });
                }),
            BottomNavigationDotBarItem(
                icon: Icons.settings,
                onTap: () {
                  setState(() {
                    currentIndex = 4;
                  });
                }),
          ]),
    );
  }
}
