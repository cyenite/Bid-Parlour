import 'package:bid_parlour/controllers/account_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentDetail extends StatefulWidget {
  final Widget child;
  final String groupId;
  PaymentDetail({Key key, this.child, this.groupId}) : super(key: key);

  _PaymentDetailState createState() => _PaymentDetailState();
}

class _PaymentDetailState extends State<PaymentDetail> {
  AccountController _accountController = Get.find<AccountController>();

  var imageNetwork = NetworkImage(
      "https://firebasestorage.googleapis.com/v0/b/beauty-look.appspot.com/o/Screenshot_20181005-213938.png?alt=media&token=8c1abb09-4acf-45cf-9383-2f94d93f4ec9");

  @override
  @override
  void initState() {
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
                        "Phone Number",
                        style: TextStyle(
                            color: Theme.of(context).hintColor,
                            fontFamily: "Popins"),
                      )),
                ),
                Container(
                    width: 100.0,
                    child: Text(
                      "Amount",
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontFamily: "Popins"),
                    )),
                Container(
                    width: 80.0,
                    child: Text(
                      "Status",
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontFamily: "Popins"),
                    )),
              ],
            ),
          ),
        ),
        _imageLoaded(context),
      ],
    );
  }

  Widget _imageLoaded(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('bids')
              .where('userId', isEqualTo: _accountController.userId.value)
              .where('groupId', isEqualTo: widget.groupId)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.docs.length == 0) {
                return SizedBox();
              } else {
                return Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (ctx, i) {
                      return listPaymentDetails(
                          snapshot.data.docs[i]['phone'],
                          snapshot.data.docs[i]['amount'].toString(),
                          snapshot.data.docs[i]['complete'],
                          ctx);
                    },
                  ),
                );
              }
            } else {
              return SizedBox();
            }
          }),
    );
  }
}

Widget listPaymentDetails(
    String phone, String amount, bool complete, BuildContext ctx) {
  return Padding(
    padding: const EdgeInsets.only(left: 12.0, top: 20.0),
    child: InkWell(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: MediaQuery.of(ctx).size.width * 0.4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  phone,
                  style: TextStyle(fontFamily: "Popins", color: Colors.white),
                ),
              ],
            ),
          ),
          Container(
            width: 100.0,
            child: Text(
              amount,
              style: TextStyle(fontFamily: "Popins", fontSize: 14.0),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Container(
                  height: 35.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                      color: complete ? Color(0xFF00C087) : Color(0xFFE19B06)),
                  child: Center(
                      child: Text(
                    complete ? "Complete" : "Pending",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.white),
                  ))),
            ),
          )
        ],
      ),
    ),
  );
}
