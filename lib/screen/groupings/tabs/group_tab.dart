import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../component/market/ethModel.dart';
import '../bid_view.dart';
import '../results_view.dart';

class GroupTab extends StatefulWidget {
  final Widget child;
  final String type;

  GroupTab({Key key, this.child, @required this.type}) : super(key: key);

  _GroupTabState createState() => _GroupTabState();
}

class _GroupTabState extends State<GroupTab> {
  var imageNetwork = NetworkImage(
      "https://firebasestorage.googleapis.com/v0/b/beauty-look.appspot.com/o/a.jpg?alt=media&token=e36bbee2-4bfb-4a94-bd53-4055d29358e2");

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
    return Container(
        child: ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
              left: 0.0, right: 0.0, top: 7.0, bottom: 2.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 22.0),
                child: Container(
                    width: 100.0,
                    child: Text(
                      "Amount",
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontFamily: "Popins"),
                    )),
              ),
              Container(
                  width: 100.0,
                  child: Text(
                    "Target",
                    style: TextStyle(
                        color: Theme.of(context).hintColor,
                        fontFamily: "Popins"),
                  )),
              Container(
                  width: 80.0,
                  child: Text(
                    "Action",
                    style: TextStyle(
                        color: Theme.of(context).hintColor,
                        fontFamily: "Popins"),
                  )),
            ],
          ),
        ),
        SizedBox(
          height: 0.0,
        ),
        _dataLoaded(context, widget.type),
      ],
    ));
  }
}

Widget _loadingData(BuildContext context) {
  return Container(
    child: ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: ethMarketList.length,
      itemBuilder: (ctx, i) {
        return loadingCard(ctx, ethMarketList[i]);
      },
    ),
  );
}

Widget loadingCard(BuildContext ctx, ethMarket item) {
  return Padding(
    padding: const EdgeInsets.only(top: 7.0),
    child: Shimmer.fromColors(
      baseColor: Color(0xFF3B4659),
      highlightColor: Color(0xFF606B78),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 12.0),
                      child: CircleAvatar(
                        backgroundColor: Theme.of(ctx).hintColor,
                        radius: 13.0,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              height: 15.0,
                              width: 60.0,
                              decoration: BoxDecoration(
                                  color: Theme.of(ctx).hintColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Container(
                            height: 12.0,
                            width: 25.0,
                            decoration: BoxDecoration(
                                color: Theme.of(ctx).hintColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 15.0,
                        width: 100.0,
                        decoration: BoxDecoration(
                            color: Theme.of(ctx).hintColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Container(
                          height: 12.0,
                          width: 35.0,
                          decoration: BoxDecoration(
                              color: Theme.of(ctx).hintColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Container(
                  height: 25.0,
                  width: 55.0,
                  decoration: BoxDecoration(
                      color: Theme.of(ctx).hintColor,
                      borderRadius: BorderRadius.all(Radius.circular(2.0))),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 20.0, top: 6.0),
            child: Container(
              width: double.infinity,
              height: 0.5,
              decoration: BoxDecoration(color: Colors.black12),
            ),
          )
        ],
      ),
    ),
  );
}

Widget _dataLoaded(BuildContext context, String type) {
  return Container(
    child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('groupings')
            .where('type', isEqualTo: type)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.docs.length == 0) {
              return _loadingData(context);
            } else {
              return Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (ctx, i) {
                    return card(context,
                        price: snapshot.data.docs[i]['price'],
                        target: snapshot.data.docs[i]['target'],
                        total: snapshot.data.docs[i]['total'],
                        complete: snapshot.data.docs[i]['complete'],
                        id: snapshot.data.docs[i].id);
                  },
                ),
              );
            }
          } else {
            return _loadingData(context);
          }
        }),
  );
}

Widget card(BuildContext ctx,
    {int price, int target, int total, bool complete, String id}) {
  double percentage = double.parse(((total / target) * 100).toStringAsFixed(1));
  return Padding(
    padding: const EdgeInsets.only(top: 7.0),
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0, right: 12.0),
                    child: Image.asset(
                      'assets/image/market/bee.png',
                      height: 22.0,
                      fit: BoxFit.contain,
                      width: 22.0,
                    ),
                  ),
                  Container(
                    width: 95.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "KES ",
                              style: TextStyle(
                                  fontFamily: "Popins",
                                  fontSize: 11.5,
                                  color: Theme.of(ctx).hintColor),
                            ),
                            Text(
                              price.toString(),
                              style: TextStyle(
                                  fontFamily: "Popins", fontSize: 16.5),
                            ),
                          ],
                        ),
                        Text(
                          'Progress: ' + total.toString(),
                          style: TextStyle(
                              fontFamily: "Popins",
                              fontSize: 11.5,
                              color: Colors.green),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 120.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'KES ' + target.toString(),
                    style: TextStyle(
                        fontFamily: "Popins",
                        fontSize: 14.5,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    percentage.toString() + '% complete',
                    style: TextStyle(
                        fontFamily: "Popins",
                        fontSize: 11.5,
                        color: Theme.of(ctx).hintColor),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: InkWell(
                onTap: complete
                    ? () {
                        Get.to(ResultView(
                          price: price,
                          target: target,
                          total: total,
                          complete: complete,
                          percentage: percentage,
                          id: id,
                        ));
                      }
                    : () {
                        Get.to(() => BidView(
                              price: price,
                              target: target,
                              total: total,
                              complete: complete,
                              percentage: percentage,
                              docId: id,
                            ));
                      },
                child: Container(
                    height: 25.0,
                    width: MediaQuery.of(ctx).size.width * 0.15,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(2.0),
                        ),
                        color: complete ? Colors.blue : Colors.green),
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Text(
                        complete ? 'Results' : 'Bid',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                    ))),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 20.0, top: 6.0),
          child: Container(
            width: double.infinity,
            height: 0.5,
            decoration: BoxDecoration(color: Colors.black12),
          ),
        )
      ],
    ),
  );
}
