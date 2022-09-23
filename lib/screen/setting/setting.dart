import 'package:bid_parlour/component/style.dart';
import 'package:bid_parlour/controllers/account_controller.dart';
import 'package:bid_parlour/helpers/database_helper.dart';
import 'package:bid_parlour/screen/setting/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Settings extends StatefulWidget {
  ThemeBloc themeBloc;

  Settings({Key key, this.themeBloc}) : super(key: key);

  _SettingsState createState() => _SettingsState(themeBloc);
}

class _SettingsState extends State<Settings> {
  ThemeBloc themeBloc;

  _SettingsState(this.themeBloc);

  bool theme = true;
  String _img = "assets/image/lightMode.png";
  AccountController _accountController = Get.find<AccountController>();

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
                    _img = "assets/image/nightMode.png";
                    theme = false;
                  });
                  themeBloc.selectedTheme.add(_buildLightTheme());
                } else {
                  themeBloc.selectedTheme.add(_buildDarkTheme());
                  setState(() {
                    theme = true;
                    _img = "assets/image/lightMode.png";
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
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return editPhoneDialog(context);
                    });
              },
              child: Obx(() {
                return listSettings(
                    "MPESA NUMBER", _accountController.phone.value);
              }),
            ),
            SizedBox(
              height: 10.0,
            ),
            InkWell(
              onTap: () {
                DbHelper.logout();
              },
              child: listSettings("LOGOUT", _accountController.email.value),
            ),
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
                color: header == "LOGOUT"
                    ? Colors.redAccent
                    : Theme.of(context).hintColor,
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

  Widget editPhoneDialog(BuildContext ctx) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    String phone = "";
    return AlertDialog(
      icon: Icon(Icons.phone),
      title: Text('Edit MPESA Number'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          initialValue: _accountController.phone.value,
          validator: (input) {
            if (input.isEmpty) {
              return 'Please enter a phone number!';
            } else {
              if (input.length < 12) {
                return 'Invalid phone number';
              }
              if (!input.startsWith("254")) {
                return 'User the format 2547****';
              }
            }
          },
          onChanged: (input) => phone = input,
          onSaved: (input) => phone = input,
          style: new TextStyle(color: Colors.white),
          textAlign: TextAlign.start,
          keyboardType: TextInputType.phone,
          autocorrect: false,
          autofocus: false,
          decoration: InputDecoration(
            border: InputBorder.none,
            icon: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Icon(
                Icons.phone_android,
                color: colorStyle.primaryColor,
                size: 20,
              ),
            ),
            contentPadding: EdgeInsets.all(0.0),
            filled: true,
            fillColor: Colors.transparent,
            labelText: 'Phone Number',
            hintStyle: TextStyle(color: Colors.white),
            labelStyle: TextStyle(
              color: Colors.white70,
            ),
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      actions: [
        InkWell(
          onTap: () {
            Navigator.of(ctx).pop();
          },
          child: Container(
            height: 40.0,
            width: MediaQuery.of(context).size.width * 0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: colorStyle.background,
            ),
            child: Center(
              child: Text(
                "Cancel",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 18.0,
                    letterSpacing: 1.0),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            final formState = _formKey.currentState;
            if (formState.validate()) {
              _accountController.phone.value = phone;
              DbHelper.editPhoneNumber(newPhone: phone);
              Navigator.of(context).pop();
            }
          },
          child: Container(
            height: 40.0,
            width: MediaQuery.of(context).size.width * 0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: colorStyle.primaryColor,
            ),
            child: Center(
              child: Text(
                "Submit",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 18.0,
                    letterSpacing: 1.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
