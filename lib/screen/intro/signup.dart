import 'package:bid_parlour/component/style.dart';
import 'package:bid_parlour/helpers/database_helper.dart';
import 'package:bid_parlour/screen/intro/login.dart';
import 'package:bid_parlour/screen/setting/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUp extends StatefulWidget {
  ThemeBloc themeBloc;
  SignUp({this.themeBloc});
  @override
  _SignUpState createState() => _SignUpState(themeBloc);
}

class _SignUpState extends State<SignUp> {
  ThemeBloc _themeBloc;
  _SignUpState(this._themeBloc);
  bool isLoading = false;
  @override
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _confPassController = TextEditingController();
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(color: colorStyle.background),
        child: Stack(
          children: <Widget>[
            Container(
              height: mediaQuery.size.height * 0.2,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/image/signupHeader.png"),
                      fit: BoxFit.cover)),
            ),
            Container(
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.only(top: mediaQuery.padding.top + 130.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset("assets/image/logo.png", height: 35.0),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 17.0, top: 7.0),
                            child: Text(
                              "Bid Parlour",
                              style: TextStyle(
                                  fontFamily: "Sans",
                                  color: Colors.white,
                                  fontSize: 27.0,
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 3.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 40.0),
                      child: _buildTextFeild(
                          widgetIcon: Icon(
                            Icons.people,
                            color: colorStyle.primaryColor,
                            size: 20,
                          ),
                          controller: _userNameController,
                          hint: 'Username',
                          obscure: false,
                          keyboardType: TextInputType.name,
                          textAlign: TextAlign.start),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 20.0),
                      child: _buildTextFeild(
                          widgetIcon: Icon(
                            Icons.email,
                            color: colorStyle.primaryColor,
                            size: 20,
                          ),
                          controller: _emailController,
                          hint: 'Email',
                          obscure: false,
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.start),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 20.0),
                      child: _buildTextFeild(
                          widgetIcon: Icon(
                            Icons.phone_android,
                            size: 20,
                            color: colorStyle.primaryColor,
                          ),
                          controller: _phoneController,
                          hint: 'M-PESA Phone Number (254*****)',
                          obscure: false,
                          errorMessage: 'Check phone number format',
                          keyboardType: TextInputType.phone,
                          textAlign: TextAlign.start),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 20.0),
                      child: _buildTextFeild(
                          widgetIcon: Icon(
                            Icons.vpn_key,
                            size: 20,
                            color: colorStyle.primaryColor,
                          ),
                          controller: _passwordController,
                          hint: 'Password',
                          obscure: true,
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.start),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 20.0),
                      child: _buildTextFeild(
                          widgetIcon: Icon(
                            Icons.vpn_key,
                            size: 20,
                            color: colorStyle.primaryColor,
                          ),
                          controller: _confPassController,
                          hint: 'Confirm Password',
                          obscure: true,
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.start),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 40.0),
                      child: GestureDetector(
                        onTap: () {
                          if (_userNameController.text.isNotEmpty ||
                              _emailController.text.isNotEmpty ||
                              _passwordController.text.isNotEmpty ||
                              _phoneController.text.isNotEmpty) {
                            if (_passwordController.text ==
                                _confPassController.text) {
                              if (_phoneController.text.startsWith("254")) {
                                setState(() {
                                  isLoading = true;
                                });
                                DbHelper.addNewUser(
                                    _userNameController.text,
                                    _emailController.text,
                                    _phoneController.text,
                                    _passwordController.text);
                              } else {
                                Get.snackbar("Oops",
                                    "We only support phone numbers with country code 254");
                              }
                            } else {
                              Get.snackbar("Error", "Passwords do not match");
                            }
                          } else {
                            Get.snackbar("Error",
                                "Make sure all the required fields are not empty");
                          }
                          /* Navigator.of(context)
                              .pushReplacement(PageRouteBuilder(
                                  pageBuilder: (_, __, ___) => BottomNavBar(
                                        themeBloc: _themeBloc,
                                      )));*/
                        },
                        child: Container(
                          height: 50.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(0.0)),
                            color: colorStyle.primaryColor,
                          ),
                          child: Center(
                            child: isLoading
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Text(
                                    "Register",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20.0,
                                        letterSpacing: 1.0),
                                  ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacement(PageRouteBuilder(
                                  pageBuilder: (_, __, ___) => Login(
                                        themeBloc: _themeBloc,
                                      )));
                        },
                        child: Container(
                          height: 50.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(0.0)),
                            border: Border.all(
                              color: colorStyle.primaryColor,
                              width: 0.35,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 17.5,
                                  letterSpacing: 1.9),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFeild({
    String hint,
    String errorMessage,
    TextEditingController controller,
    TextInputType keyboardType,
    bool obscure,
    String icon,
    TextAlign textAlign,
    Widget widgetIcon,
  }) {
    return Column(
      children: <Widget>[
        Container(
          height: 53.5,
          decoration: BoxDecoration(
            color: Colors.black26,
//              color: Color(0xFF282E41),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            border: Border.all(
              color: colorStyle.primaryColor,
              width: 0.15,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 10.0),
            child: Theme(
              data: ThemeData(hintColor: Colors.transparent),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: TextField(
                  style: new TextStyle(color: Colors.white),
                  textAlign: textAlign,
                  obscureText: obscure,
                  controller: controller,
                  keyboardType: keyboardType,
                  autocorrect: false,
                  autofocus: false,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: widgetIcon,
                      ),
                      contentPadding: EdgeInsets.all(0.0),
                      errorText: errorMessage == null
                          ? 'Check this Field'
                          : errorMessage,
                      filled: true,
                      fillColor: Colors.transparent,
                      labelText: hint,
                      hintStyle: TextStyle(color: Colors.white),
                      labelStyle: TextStyle(
                        color: Colors.white70,
                      )),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
