import 'dart:async';

import 'package:bid_parlour/controllers/account_controller.dart';
import 'package:bid_parlour/helpers/payment_helper.dart';
import 'package:bid_parlour/screen/groupings/detail/payment_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helpers/database_helper.dart';

class BidView extends StatefulWidget {
  String docId;
  String type;
  BidView({Key key, this.docId, this.type}) : super(key: key);

  _BidViewState createState() => _BidViewState();
}

class _BidViewState extends State<BidView> with SingleTickerProviderStateMixin {
  AccountController _accountController = Get.find<AccountController>();
  String progressAmount = "0";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        centerTitle: true,
        title: Text(
          'KES. ' + progressAmount,
          style: TextStyle(
              fontFamily: "Gotik", fontWeight: FontWeight.w600, fontSize: 18.5),
        ),
        iconTheme: IconThemeData(),
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('groupings')
              .doc(widget.docId)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              progressAmount = snapshot.data['price'].toString();
              return Column(
                children: <Widget>[
                  SizedBox(
                    height: 5.0,
                  ),
                  Expanded(
                    child: DefaultTabController(
                      length: 1,
                      child: new Scaffold(
                        backgroundColor: Colors.transparent,
                        appBar: PreferredSize(
                          preferredSize:
                              Size.fromHeight(42.0), // here the desired height
                          child: new AppBar(
                            backgroundColor: Colors.transparent,
                            elevation: 0.0,
                            centerTitle: true,
                            automaticallyImplyLeading: false,
                            title: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  border: Border.all(color: Colors.black54),
                                  color: Colors.black26),
                              child: new TabBar(
                                indicatorColor: Theme.of(context).accentColor,
                                labelColor: Theme.of(context).accentColor,
                                unselectedLabelColor:
                                    Theme.of(context).hintColor,
                                indicator: ShapeDecoration.fromBoxDecoration(
                                    BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0)),
                                        color: Theme.of(context).canvasColor)),
                                tabs: [
                                  new Tab(
                                    child: Text(
                                      "Progress: ${snapshot.data['price']}",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        body: new TabBarView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0, top: 20.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      width: double.infinity,
                                      height: 140.0,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).canvasColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0,
                                                right: 20.0,
                                                top: 20.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  "Value (KES)",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .hintColor
                                                          .withOpacity(0.5),
                                                      fontFamily: "Popins",
                                                      fontSize: 15.5),
                                                ),
                                                Text(
                                                  snapshot.data['target']
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontFamily: "Popins"),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0,
                                                right: 20.0,
                                                top: 10.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  "Bid amount",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .hintColor
                                                          .withOpacity(0.5),
                                                      fontFamily: "Popins",
                                                      fontSize: 15.5),
                                                ),
                                                Text(
                                                  snapshot.data['price']
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontFamily: "Popins"),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0,
                                                right: 20.0,
                                                top: 10.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  "Progress",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .hintColor
                                                          .withOpacity(0.5),
                                                      fontFamily: "Popins",
                                                      fontSize: 15.5),
                                                ),
                                                Text(
                                                  double.parse(((snapshot.data[
                                                                          'total'] /
                                                                      snapshot.data[
                                                                          'target']) *
                                                                  100)
                                                              .toStringAsFixed(
                                                                  1))
                                                          .toString() +
                                                      "%",
                                                  style: TextStyle(
                                                    fontFamily: "Popins",
                                                    color: Theme.of(context)
                                                        .hintColor
                                                        .withOpacity(0.5),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Container(
                                      height: 125.0,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).canvasColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(
                                            height: 20.0,
                                          ),
                                          Text(
                                            "KES " + progressAmount,
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .hintColor
                                                  .withOpacity(0.7),
                                              fontFamily: "Popins",
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15.0,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              PaymentHelper.makePayment(
                                                      target: snapshot
                                                          .data['target'],
                                                      amount: snapshot
                                                          .data['price'],
                                                      total: snapshot
                                                          .data['total'],
                                                      id: widget.docId,
                                                      userId: _accountController
                                                          .userId.value,
                                                      type:
                                                          snapshot.data['type'])
                                                  .then((value) {
                                                if (value != null &&
                                                    value['successful']) {
                                                  print(value);
                                                  Timer.periodic(
                                                      Duration(seconds: 3),
                                                      (timer) {
                                                    PaymentHelper.invoiceStatus(
                                                            value['invoice_id'])
                                                        .then((value2) {
                                                      if (value2) {
                                                        DbHelper.verifyBid(
                                                            invoiceId: value[
                                                                'invoice_id'],
                                                            total: snapshot
                                                                .data['total'],
                                                            amount: 10,
                                                            groupId:
                                                                widget.docId);
                                                        /*DbHelper.verifyBid(
                                                            invoiceId: value[
                                                                'invoice_id'],
                                                            total: snapshot
                                                                .data['total'],
                                                            amount: snapshot
                                                                .data['amount'],
                                                            groupId:
                                                                widget.docId);*/
                                                      }
                                                    });
                                                  });
                                                } else {
                                                  Get.snackbar("Error",
                                                      "Payment not successful");
                                                }
                                              });
                                            },
                                            child: Container(
                                              height: 40.0,
                                              width: 150.0,
                                              color: Colors.green,
                                              child: Center(
                                                child: Text(
                                                  "BID",
                                                  style: TextStyle(),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    SingleChildScrollView(
                                      child: PaymentDetail(
                                        groupId: widget.docId,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.blue,
              ));
            }
          }),
    );
  }
}
