import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../component/gainersModel.dart';

class ActiveBid extends StatefulWidget {
  final Widget child;

  ActiveBid({Key key, this.child}) : super(key: key);

  _ActiveBidState createState() => _ActiveBidState();
}

class _ActiveBidState extends State<ActiveBid> {
  var imageNetwork = NetworkImage(
      "https://firebasestorage.googleapis.com/v0/b/beauty-look.appspot.com/o/Screenshot_20181005-213938.png?alt=media&token=8c1abb09-4acf-45cf-9383-2f94d93f4ec9");
  bool loadImage = true;

  @override
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      setState(() {
        loadImage = false;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Theme.of(context).canvasColor,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 0.0, right: 0.0, top: 7.0, bottom: 7.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Container(
                      width: 100.0,
                      child: Text(
                        "Package",
                        style: TextStyle(
                            color: Theme.of(context).hintColor,
                            fontFamily: "Popins"),
                      )),
                ),
                Container(
                    width: 100.0,
                    child: Text(
                      "Maturity Date",
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontFamily: "Popins"),
                    )),
                Container(
                    width: 80.0,
                    child: Text(
                      "Profit",
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontFamily: "Popins"),
                    )),
              ],
            ),
          ),
        ),
        loadImage ? _loadingImageAnimation(context) : _imageLoaded(context),
      ],
    );
  }
}

Widget listPriceActiveBids(ActiveBids item, BuildContext ctx) {
  return Padding(
    padding: const EdgeInsets.only(left: 12.0, top: 20.0),
    child: InkWell(
      onTap: () {
        /*Navigator.of(ctx).push(PageRouteBuilder(
            pageBuilder: (_, __, ___) => new ActiveBidsDetail(
                  item: item,
                )));*/
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 100.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  item.pair,
                  style: TextStyle(fontFamily: "Popins", fontSize: 16.5),
                ),
                Text(
                  "",
                  style: TextStyle(
                      fontFamily: "Popins",
                      fontSize: 11.5,
                      color: Theme.of(ctx).hintColor),
                )
              ],
            ),
          ),
          Container(
            width: 100.0,
            child: Text(
              item.lastPrice,
              style: TextStyle(fontFamily: "Popins", fontSize: 14.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
                width: 80.0,
                height: 35.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(2.0)),
                    color: Color(0xFF00C087)),
                child: Center(
                    child: Text(
                  item.chg,
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.white),
                ))),
          )
        ],
      ),
    ),
  );
}

Widget loadingListPriceActiveBids(ActiveBids item, BuildContext ctx) {
  return Padding(
    padding: const EdgeInsets.only(left: 12.0, top: 17.0),
    child: Shimmer.fromColors(
      baseColor: Color(0xFF3B4659),
      highlightColor: Color(0xFF606B78),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 70.0,
            height: 20.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: Theme.of(ctx).hintColor,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                color: Theme.of(ctx).hintColor,
              ),
              height: 20.0,
              width: 70.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Theme.of(ctx).hintColor,
              ),
              height: 20.0,
              width: 115.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              color: Theme.of(ctx).hintColor,
              width: 80.0,
              height: 35.0,
            ),
          )
        ],
      ),
    ),
  );
}

Widget _loadingImageAnimation(BuildContext context) {
  return Container(
    child: ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: ActiveBidsList.length,
      itemBuilder: (ctx, i) {
        return loadingListPriceActiveBids(ActiveBidsList[i], ctx);
      },
    ),
  );
}

Widget _imageLoaded(BuildContext context) {
  return Container(
    child: ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: ActiveBidsList.length,
      itemBuilder: (ctx, i) {
        return listPriceActiveBids(ActiveBidsList[i], ctx);
      },
    ),
  );
}
