import 'dart:async';

import 'package:bid_parlour/controllers/account_controller.dart';
import 'package:bid_parlour/screen/Bottom_Nav_Bar/bottom_nav_bar.dart';
import 'package:bid_parlour/screen/intro/on_Boarding.dart';
import 'package:bid_parlour/screen/setting/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(AccountController());
  runApp(myApp());
}

class myApp extends StatefulWidget {
  final Widget child;

  myApp({Key key, this.child}) : super(key: key);

  _myAppState createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  ThemeBloc _themeBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _themeBloc = ThemeBloc();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return StreamBuilder<ThemeData>(
      initialData: _themeBloc.initialTheme().data,
      stream: _themeBloc.themeDataStream,
      builder: (BuildContext context, AsyncSnapshot<ThemeData> snapshot) {
        return GetMaterialApp(
          title: 'Bid Parlour',
          theme: snapshot.data,
          debugShowCheckedModeBanner: false,
          home: SplashScreen(
            themeBloc: _themeBloc,
          ),
          routes: <String, WidgetBuilder>{
            "OnBoarding": (BuildContext context) =>
                OnBoarding(themeBloc: _themeBloc)
          },
        );
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  ThemeBloc themeBloc;
  SplashScreen({this.themeBloc});
  @override
  _SplashScreenState createState() => _SplashScreenState(themeBloc);
}

class _SplashScreenState extends State<SplashScreen> {
  ThemeBloc themeBloc;
  _SplashScreenState(this.themeBloc);
  Widget nextScreen = OnBoarding();
  AccountController _accountController = Get.find<AccountController>();
  @override
  startTime() async {
    return new Timer(Duration(milliseconds: 4500), NavigatorPage);
  }

  void NavigatorPage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (c) {
      return nextScreen;
    }));
  }

  void getAuthStatus() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    nextScreen = _prefs.getBool('isLoggedIn')
        ? BottomNavBar()
        : OnBoarding(
            themeBloc: this.themeBloc,
          );
    if (_prefs.getBool('isLoggedIn')) {
      _accountController.phone.value = _prefs.getString("phone");
      _accountController.userId.value = _prefs.getString("userId");
      _accountController.userName.value = _prefs.getString("userName");
      _accountController.email.value = _prefs.get("email");
    }
  }

  @override
  void initState() {
    super.initState();
    startTime();
    getAuthStatus();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/image/splash_screen.png'),
                fit: BoxFit.cover)),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                Color.fromRGBO(0, 0, 0, 0.1),
                Color.fromRGBO(0, 0, 0, 0.1)
              ],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter)),
          child: Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset("assets/image/logo.png", height: 35.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 17.0, top: 7.0),
                        child: Text(
                          "Bid Parlour",
                          style: TextStyle(
                              fontFamily: "Sans",
                              color: Colors.white,
                              fontSize: 32.0,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 3.9),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
