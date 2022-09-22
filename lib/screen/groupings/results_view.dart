import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

class ResultView extends StatefulWidget {
  int price;
  int target;
  int total;
  bool complete;
  double percentage;
  String id;

  ResultView(
      {Key key,
      this.price,
      this.target,
      this.total,
      this.complete,
      this.percentage,
      this.id})
      : super(key: key);

  _ResultViewState createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        brightness: Brightness.dark,
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "Bid Results",
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Theme.of(context).hintColor,
        ),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _headerValue(),
                      SizedBox(
                        height: 35.0,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Stack(
                    children: <Widget>[
                      ///
                      /// Calling vertical value grafik
                      ///
                      _verticalValueGrafik(),

                      ///
                      /// Calling sparkLine Grafik
                      ///
                      _sparkLineGrafic(),
                    ],
                  ),
                ),

                ///
                /// Calling horizontal value grafik
                ///
                _horizontalValueGrafik(),
                SizedBox(
                  height: 20.0,
                ),
                _buttonBottom(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttonBottom() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            height: 50.0,
            width: 140.0,
            child: MaterialButton(
              splashColor: Colors.black12,
              highlightColor: Colors.black12,
              color: Colors.greenAccent.withOpacity(0.8),
              onPressed: () {},
              child: Center(
                  child: Text(
                "Bid Again",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Popins",
                    letterSpacing: 1.3,
                    fontSize: 16.0),
              )),
            ),
          ),
          SizedBox(
            width: 0.0,
          ),
          Container(
            height: 50.0,
            width: 140.0,
            child: MaterialButton(
              splashColor: Colors.black12,
              highlightColor: Colors.black12,
              color: Colors.redAccent.withOpacity(0.8),
              onPressed: () {},
              child: Center(
                  child: Text(
                "Exit",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Popins",
                    letterSpacing: 1.3,
                    fontSize: 16.0),
              )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _line() {
    return Container(
      height: 0.2,
      width: double.infinity,
      color: Theme.of(context).hintColor,
    );
  }

  Widget _headerValue() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              widget.total.toString(),
              style: TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 34.0,
                  fontFamily: "Sans",
                  fontWeight: FontWeight.w700),
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Text(
                        "Price",
                        style: TextStyle(
                            color: Theme.of(context).hintColor,
                            fontFamily: "Popins",
                            fontSize: 12.5),
                      ),
                    ),
                    SizedBox(
                      height: 7.0,
                    ),
                    Text(widget.price.toString())
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Text(
                        "Status",
                        style: TextStyle(
                            color: Theme.of(context).hintColor,
                            fontFamily: "Popins",
                            fontSize: 12.5),
                      ),
                    ),
                    Text("completed")
                  ],
                )
              ],
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  "Winner: ",
                  style: TextStyle(
                      color: Theme.of(context).hintColor,
                      fontFamily: "Popins",
                      fontSize: 12.5),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Cy3nite",
                    style: TextStyle(color: Colors.greenAccent),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 31.0),
                  child: Text(
                    "",
                    style: TextStyle(
                        color: Theme.of(context).hintColor,
                        fontFamily: "Popins",
                        fontSize: 12.5),
                  ),
                ),
                Text("")
              ],
            )
          ],
        ),
      ],
    );
  }

  Widget _verticalValueGrafik() {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Stack(children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 70.0),
                    child: _line()),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "500.0000",
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontFamily: "Popins",
                          fontSize: 11.5),
                    ))
              ]),
              Stack(children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 70.0),
                    child: _line()),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "400.0000",
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontFamily: "Popins",
                          fontSize: 11.5),
                    ))
              ]),
              Stack(children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 70.0),
                    child: _line()),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "300.0000",
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontFamily: "Popins",
                          fontSize: 11.5),
                    ))
              ]),
              Stack(children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 70.0),
                    child: _line()),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "200.0000",
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontFamily: "Popins",
                          fontSize: 11.5),
                    ))
              ]),
              Stack(children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 70.0),
                    child: _line()),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "100.0000",
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontFamily: "Popins",
                          fontSize: 11.5),
                    ))
              ]),
              Stack(children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 30.0),
                    child: _line()),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "0.0000",
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontFamily: "Popins",
                          fontSize: 11.5),
                    ))
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sparkLineGrafic() {
    return Stack(
      children: [
        Positioned.fill(
          child: Center(
            child: Text(
              'BID PARLOUR',
              style: TextStyle(
                  color: Theme.of(context).hintColor,
                  fontFamily: "Popins",
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
          ),
        ),
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: new Sparkline(
              data: [
                0.0,
                0.5,
                0.9,
                0.8,
                1.2,
                1.3,
                3.3,
                4.0,
                4.5,
                5.0,
                5.5,
                6.0,
                6.0
              ],
              lineWidth: 0.3,
              fillMode: FillMode.below,
              lineColor: Colors.greenAccent,
              fillGradient: new LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.greenAccent.withOpacity(0.2),
                  Colors.greenAccent.withOpacity(0.01)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _backgroundLine() {
    return Container(
        height: 13.2,
        width: double.infinity,
        color: Theme.of(context).canvasColor);
  }

  Widget _horizontalValueGrafik() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "1.00 pm",
            style: TextStyle(
                color: Theme.of(context).hintColor,
                fontFamily: "Popins",
                fontSize: 11.5),
          ),
          Text(
            "1.15 pm",
            style: TextStyle(
                color: Theme.of(context).hintColor,
                fontFamily: "Popins",
                fontSize: 11.5),
          ),
          Text(
            "1.30 pm",
            style: TextStyle(
                color: Theme.of(context).hintColor,
                fontFamily: "Popins",
                fontSize: 11.5),
          ),
          Text(
            "1.45 pm",
            style: TextStyle(
                color: Theme.of(context).hintColor,
                fontFamily: "Popins",
                fontSize: 11.5),
          ),
          Text(
            "2.00 pm",
            style: TextStyle(
                color: Theme.of(context).hintColor,
                fontFamily: "Popins",
                fontSize: 11.5),
          ),
          Text(
            "2.15 pm",
            style: TextStyle(
                color: Theme.of(context).hintColor,
                fontFamily: "Popins",
                fontSize: 11.5),
          ),
        ],
      ),
    );
  }
}
