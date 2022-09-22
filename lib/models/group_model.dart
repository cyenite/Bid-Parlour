import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class GroupModel {
  int price;
  int target;
  int total;
  bool complete;
  String type;

  GroupModel(
      {@required this.target,
      @required this.price,
      @required this.total,
      @required this.complete,
      @required this.type});

  factory GroupModel.fromDocumentSnapShot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    return GroupModel(
        target: doc['target'],
        price: doc['price'],
        total: doc['total'],
        complete: doc['complete'],
        type: doc['type']);
  }
}
