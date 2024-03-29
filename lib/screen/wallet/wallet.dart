import 'dart:math';

import 'package:bid_parlour/component/AssetsWallet/assetsModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vector_math/vector_math.dart' as Vector;

import '../../controllers/account_controller.dart';

class Wallet extends StatefulWidget {
  @override
  _WalletState createState() => new _WalletState();

  Wallet() {
    timeDilation = 1.0;
  }
}

class _WalletState extends State<Wallet> {
  @override
  assetsWallet item;
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    Size size = new Size(MediaQuery.of(context).size.width, 200.0);
    return new Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 225.0),
            child: Container(
                child: ListView.builder(
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.only(top: 0.0),
              itemBuilder: (ctx, i) {
                return card(assetsWalletList[i], ctx);
              },
              itemCount: assetsWalletList.length,
            )),
          ),
          Column(
            children: <Widget>[
              new Stack(
                children: <Widget>[
                  new waveBody(
                      size: size, xOffset: 0, yOffset: 0, color: Colors.red),
                  new Opacity(
                    opacity: 0.9,
                    child: new waveBody(
                      size: size,
                      xOffset: 60,
                      yOffset: 10,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 13.0, right: 13.0, top: 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Amount(KES)",
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontFamily: "Popins",
                          fontSize: 14.0),
                    ),
                    Text(
                      "Payment status",
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontFamily: "Popins",
                          fontSize: 14.0),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class waveBody extends StatefulWidget {
  final Size size;
  final int xOffset;
  final int yOffset;
  final Color color;

  waveBody(
      {Key key, @required this.size, this.xOffset, this.yOffset, this.color})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _waveBodyState();
  }
}

class _waveBodyState extends State<waveBody> with TickerProviderStateMixin {
  AnimationController animationController;
  List<Offset> animList1 = [];

  @override
  void initState() {
    super.initState();

    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 2));

    animationController.addListener(() {
      animList1.clear();
      for (int i = -2 - widget.xOffset;
          i <= widget.size.width.toInt() + 2;
          i++) {
        animList1.add(new Offset(
            i.toDouble() + widget.xOffset,
            sin((animationController.value * 360 - i) %
                        360 *
                        Vector.degrees2Radians) *
                    20 +
                50 +
                widget.yOffset));
      }
    });
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 185.0,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  tileMode: TileMode.repeated,
                  colors: [Color(0xFF00FF0E), Color(0xFF029CF5)])),
          child: new Container(
            margin: EdgeInsets.only(top: 75.0),
            height: 20.0,
            child: new AnimatedBuilder(
              animation: new CurvedAnimation(
                parent: animationController,
                curve: Curves.easeInOut,
              ),
              builder: (context, child) => new ClipPath(
                child: widget.color == null
                    ? new Container(
                        width: widget.size.width,
                        height: widget.size.height,
                        color: Colors.white.withOpacity(0.25),
                      )
                    : new Container(
                        width: widget.size.width,
                        height: widget.size.height,
                        color: Colors.white.withOpacity(0.9),
                      ),
                clipper: new WaveClipper(animationController.value, animList1),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 180.0),
          height: 5.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: <Color>[
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.1),
                  Theme.of(context).scaffoldBackgroundColor
                ],
                stops: [
                  0.0,
                  1.0
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(0.0, 1.0)),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 70.0),
          alignment: Alignment.topCenter,
          child: Column(children: <Widget>[
            Text(
              "Wallet Balance",
              style: TextStyle(fontFamily: "Popins", color: Colors.white),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              "KES 3,200",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFamily: "Popins",
                  fontSize: 30.0,
                  color: Colors.white),
            ),
          ]),
        )
      ],
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  final double animation;

  List<Offset> waveList1 = [];

  WaveClipper(this.animation, this.waveList1);

  @override
  Path getClip(Size size) {
    Path path = new Path();

    path.addPolygon(waveList1, false);

    path.lineTo(size.width, size.height);
    path.lineTo(5.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(WaveClipper oldClipper) =>
      animation != oldClipper.animation;
}

Widget card(assetsWallet item, BuildContext ctx) {
  AccountController _accountController = Get.find<AccountController>();
  return Padding(
    padding: const EdgeInsets.only(top: 7.0),
    child: Column(
      children: <Widget>[
        InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Container(
                        width: 95.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              item.amount,
                              style: TextStyle(
                                  fontFamily: "Popins", fontSize: 16.5),
                            ),
                            Text(
                              "Paid to: " + _accountController.phone.value,
                              style: TextStyle(
                                  fontFamily: "Popins",
                                  fontSize: 11.5,
                                  color: Theme.of(ctx).hintColor),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Container(
                    height: 35.0,
                    width: MediaQuery.of(ctx).size.width * 0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(2.0)),
                        color: item.status == "Complete"
                            ? Colors.green
                            : Colors.blue),
                    child: Center(
                        child: Text(
                      item.status,
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.white),
                    ))),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 20.0, top: 6.0),
          child: Container(
            width: double.infinity,
            height: 0.5,
            decoration:
                BoxDecoration(color: Theme.of(ctx).hintColor.withOpacity(0.1)),
          ),
        )
      ],
    ),
  );
}
