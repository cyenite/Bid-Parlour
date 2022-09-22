import 'dart:async';

import 'package:bid_parlour/component/modelGridHome.dart';
import 'package:bid_parlour/component/style.dart';
import 'package:bid_parlour/screen/home/active_bid.dart';
import 'package:bid_parlour/screen/home/past_bid.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:shimmer/shimmer.dart';

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var imageNetwork = NetworkImage(
      "https://firebasestorage.googleapis.com/v0/b/beauty-look.appspot.com/o/Screenshot_20181005-213938.png?alt=media&token=8c1abb09-4acf-45cf-9383-2f94d93f4ec9");

  bool loadCard = true;

  @override
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      setState(() {
        loadCard = false;
      });
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
                height: 210.0,
                width: double.infinity,
                child: new Carousel(
                  boxFit: BoxFit.cover,
                  dotColor: Colors.white.withOpacity(0.8),
                  dotSize: 5.5,
                  dotSpacing: 16.0,
                  dotBgColor: Colors.transparent,
                  showIndicator: true,
                  overlayShadow: true,
                  overlayShadowColors: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.9),
                  overlayShadowSize: 0.25,
                  images: [
                    AssetImage("assets/image/banner/banner1.png"),
                    AssetImage("assets/image/banner/banner3.jpg"),
                    AssetImage("assets/image/banner/banner1.png"),
                    AssetImage("assets/image/banner/banner3.jpg"),
                  ],
                )),
            SizedBox(height: 10.0),
            loadCard ? _loadingCardAnimation(context) : _cardLoaded(context),
            Container(
              height: 700.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: DefaultTabController(
                      length: 2,
                      child: new Scaffold(
                        appBar: PreferredSize(
                          preferredSize:
                              Size.fromHeight(53.0), // here the desired height
                          child: new AppBar(
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            elevation: 0.0,
                            centerTitle: true,
                            flexibleSpace: SafeArea(
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 100.0),
                                  child: new TabBar(
                                    indicatorColor: colorStyle.primaryColor,
                                    labelColor: Theme.of(context).primaryColor,
                                    indicatorSize: TabBarIndicatorSize.label,
                                    tabs: [
                                      new Tab(
                                        child: Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4.0),
                                              child: Icon(
                                                Icons.access_time,
                                                size: 15.0,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                "Active Bids",
                                                style: TextStyle(
                                                    fontFamily: "Sans"),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      new Tab(
                                        child: Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Icon(
                                                Icons.history,
                                                size: 15.0,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text("Past Bids"),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            automaticallyImplyLeading: false,
                          ),
                        ),
                        body: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: new TabBarView(
                            children: [
                              ActiveBid(),
                              PastBid(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class card extends StatelessWidget {
  gridHome item;
  card(this.item);
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 70.0,
          width: _width / 2.2,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              color: Theme.of(context).canvasColor,
              boxShadow: [
                BoxShadow(
                    color: Color(0xFF656565).withOpacity(0.15),
                    blurRadius: 1.0,
                    spreadRadius: 1.0,
                    offset: Offset(0.1, 1.0))
              ]),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item.name,
                      style: TextStyle(
                          fontFamily: "Popins",
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            item.valueMarket,
                            style: TextStyle(
                                color: item.chartColor,
                                fontFamily: "Gotik",
                                fontSize: 13.5),
                          ),
                          Text(
                            item.valuePercent,
                            style: TextStyle(color: item.chartColor),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 30.0,
                  child: new Sparkline(
                    data: item.data,
                    lineWidth: 0.3,
                    fillMode: FillMode.below,
                    lineColor: item.chartColor,
                    fillGradient: new LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: item.chartColorGradient,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class cardLoading extends StatelessWidget {
  gridHome item;
  cardLoading(this.item);
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
      child: Container(
        height: 70.0,
        width: _width / 2.2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            color: Theme.of(context).canvasColor,
            boxShadow: [
              BoxShadow(
                  color: Color(0xFF656565).withOpacity(0.15),
                  blurRadius: 1.0,
                  spreadRadius: 1.0,
                  offset: Offset(0.1, 1.0))
            ]),
        child: Shimmer.fromColors(
          baseColor: Color(0xFF3B4659),
          highlightColor: Color(0xFF606B78),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      color: Theme.of(context).hintColor,
                      height: 20.0,
                      width: 70.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 17.0,
                            width: 70.0,
                          ),
                          Container(
                            color: Theme.of(context).hintColor,
                            height: 17.0,
                            width: 70.0,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 30.0,
                  child: new Sparkline(
                    data: item.data,
                    lineWidth: 0.3,
                    fillMode: FillMode.below,
                    lineColor: item.chartColor,
                    fillGradient: new LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: item.chartColorGradient,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///
///
/// Calling imageLoading animation for set a grid layout
///
///
Widget _loadingCardAnimation(BuildContext context) {
  return GridView.count(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
      crossAxisSpacing: 12.0,
      mainAxisSpacing: 12.0,
      childAspectRatio: 1.745,
      crossAxisCount: 2,
      primary: false,
      children: List.generate(
        listGridHome.length,
        (index) => cardLoading(listGridHome[index]),
      ));
}

///
///
/// Calling ImageLoaded animation for set a grid layout
///
///
Widget _cardLoaded(BuildContext context) {
  return GridView.count(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
      crossAxisSpacing: 12.0,
      mainAxisSpacing: 12.0,
      childAspectRatio: 1.745,
      crossAxisCount: 2,
      primary: false,
      children: List.generate(
        listGridHome.length,
        (index) => card(listGridHome[index]),
      ));
}
