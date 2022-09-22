import 'package:bid_parlour/component/style.dart';
import 'package:bid_parlour/screen/setting/themes.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  ThemeBloc themeBloc;

  Settings({Key key, this.themeBloc}) : super(key: key);

  _SettingsState createState() => _SettingsState(themeBloc);
}

class _SettingsState extends State<Settings> {
  ThemeBloc themeBloc;
  _SettingsState(this.themeBloc);
  bool theme = true;
  String _img = "assets/image/Settings/lightMode.png";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Center(
                  child: Text(
                "Settings",
                style: TextStyle(
                    fontFamily: "Sans",
                    fontSize: 19.5,
                    fontWeight: FontWeight.w700),
              )),
            ),
            SizedBox(
              height: 20.0,
            ),
            InkWell(
              onTap: () {
                if (theme == true) {
                  setState(() {
                    _img = "assets/image/Settings/nightMode.png";
                    theme = false;
                  });
                  themeBloc.selectedTheme.add(_buildLightTheme());
                } else {
                  themeBloc.selectedTheme.add(_buildDarkTheme());
                  setState(() {
                    theme = true;
                    _img = "assets/image/Settings/lightMode.png";
                  });
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Container(
                  height: 125.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      image: DecorationImage(
                          image: AssetImage(_img), fit: BoxFit.cover)),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            listSettings("PASSCODE LOCK", "Disable"),
            SizedBox(
              height: 10.0,
            ),
            listSettings("LANGUAGE", "English"),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget listSettings(String header, String title) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            header,
            style: TextStyle(
                color: Theme.of(context).hintColor,
                fontFamily: "Sans",
                fontSize: 13.0),
          ),
          SizedBox(
            height: 9.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                    fontSize: 17.0,
                    fontFamily: "Popins",
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w300),
              ),
              Icon(Icons.keyboard_arrow_right)
            ],
          ),
          line()
        ],
      ),
    );
  }

  Widget line() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        width: double.infinity,
        height: 0.5,
        decoration: BoxDecoration(color: Theme.of(context).hintColor),
      ),
    );
  }

  ///
  /// Change to mode light theme
  ///
  DemoTheme _buildLightTheme() {
    return DemoTheme(
        'light',
        ThemeData(
          brightness: Brightness.light,
          accentColor: colorStyle.primaryColor,
          primaryColor: colorStyle.primaryColor,
          buttonColor: colorStyle.primaryColor,
          cardColor: colorStyle.cardColorLight,
          scaffoldBackgroundColor: Color(0xFFFDFDFD),
          canvasColor: colorStyle.whiteBacground,
          dividerColor: colorStyle.iconColorLight,
          hintColor: colorStyle.fontSecondaryColorLight,
        ));
  }

  ///
  /// Change to mode dark theme
  ///
  DemoTheme _buildDarkTheme() {
    return DemoTheme(
        'dark',
        ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: colorStyle.background,
          backgroundColor: colorStyle.blackBackground,
          dividerColor: colorStyle.iconColorDark,
          accentColor: colorStyle.primaryColor,
          primaryColor: colorStyle.primaryColor,
          hintColor: colorStyle.fontSecondaryColorDark,
          buttonColor: colorStyle.primaryColor,
          canvasColor: colorStyle.grayBackground,
          cardColor: colorStyle.grayBackground,
        ));
  }
}
