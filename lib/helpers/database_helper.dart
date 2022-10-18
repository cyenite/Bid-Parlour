import 'package:bid_parlour/screen/Bottom_Nav_Bar/bottom_nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/account_controller.dart';
import '../screen/intro/login.dart';

class DbHelper {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  RxBool isDoctor = false.obs;
  final AccountController _accountController = Get.find<AccountController>();

  static addNewUser(
      String name, String email, String phone, String password) async {
    UserCredential result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    User user = result.user;
    Map<String, dynamic> userData = {
      "name": name,
      "email": email,
      "phone": phone,
      "last_login": user.metadata.lastSignInTime.millisecondsSinceEpoch,
      "created_at": user.metadata.creationTime.millisecondsSinceEpoch,
    };
    final userRef = _db.collection("users").doc(user.uid);
    AccountController _accountController = Get.find<AccountController>();
    _accountController.userId.value = user.uid;
    try {
      if ((await userRef.get()).exists) {
        var docSnapshot = await _db.collection("users").doc(user.uid).get();
        await userRef.update({
          "last_login": user.metadata.lastSignInTime.millisecondsSinceEpoch,
        }).then((value) {
          if (docSnapshot.exists) {
            Map<String, dynamic> data = docSnapshot.data();
            _accountController.userName.value = data['name'];
            _accountController.email.value = data['email'];
            _accountController.phone.value = data['phone'];
          }

          updatePreference(true);
          Get.off(() => BottomNavBar());
        });
      } else {
        await _db.collection("users").doc(user.uid).set(userData).then((value) {
          AccountController _accountController = Get.find<AccountController>();
          _accountController.userName.value = name;
          _accountController.email.value = email;
          _accountController.phone.value = phone;
          updatePreference(true);
          Get.off(() => BottomNavBar());
        });
      }
    } catch (e) {
      print(e);
      Get.back();
      return false;
    }
  }

  static signInUser(String email, String password) async {
    UserCredential result = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => value, onError: (error) {
      Get.snackbar("Oops", error.message);
      Get.off(() => Login());
    });
    User user = result.user;
    AccountController _accountController = Get.find<AccountController>();
    final userRef = _db.collection("users").doc(user.uid);
    _accountController.userId.value = user.uid;
    try {
      var docSnapshot = await _db.collection("users").doc(user.uid).get();
      await userRef.update({
        "last_login": user.metadata.lastSignInTime.millisecondsSinceEpoch,
      }).then((value) {
        if (docSnapshot.exists) {
          _accountController.userId.value = docSnapshot.id;
          Map<String, dynamic> data = docSnapshot.data();
          _accountController.userName.value = data['name'];
          _accountController.email.value = data['email'];
          _accountController.phone.value = data['phone'];
          if (kDebugMode) {
            print(data['role']);
          }
        }
        updatePreference(true);
        Get.clearRouteTree();
        Get.off(() => BottomNavBar());
      });
    } catch (e) {
      print(e);
      Get.snackbar("Oops", e);
      return false;
    }
  }

  static makeBid(
      {int target,
      int amount,
      int total,
      String id,
      String userId,
      String invoiceId,
      String groupId,
      String type}) {
    AccountController _accountController = Get.find<AccountController>();
    print("adding bids");

    _db.collection("bids").doc(invoiceId).set({
      "userId": userId,
      "amount": amount,
      "groupId": id,
      "type": type,
      "invoiceId": invoiceId,
      "complete": false,
      "phone": _accountController.phone.value,
    });
  }

  static verifyBid({String invoiceId, int total, int amount, String groupId}) {
    _db.collection("bids").doc(invoiceId).update({
      "complete": true,
    });

    /* _db.collection('groupings').doc(groupId).update({
      "total": total + amount,
    });*/
  }

  static editPhoneNumber({String newPhone}) {
    AccountController _accountController = Get.find<AccountController>();
    _db.collection("users").doc(_accountController.userId.value).update({
      "phone": newPhone,
    });
  }

  void saveUser(User user) async {
    Map<String, dynamic> userData = {
      "name": user.displayName,
      "email": user.email,
      "last_login": user.metadata.lastSignInTime.millisecondsSinceEpoch,
      "created_at": user.metadata.creationTime.millisecondsSinceEpoch,
      "role": "",
    };
    final userRef = _db.collection("users").doc(user.uid);
    if ((await userRef.get()).exists) {
      await userRef.update({
        "last_login": user.metadata.lastSignInTime.millisecondsSinceEpoch,
      });
    } else {
      await _db.collection("users").doc(user.uid).set(userData);
    }
    updatePreference(true);
  }

  static makeWithdrawalRequest(
      {String userId, String payoutId, String amount}) {
    Map<String, dynamic> reqData = {
      "userId": userId,
      "payoutId": payoutId,
      "amount": amount
    };
    final dbRef =
        _db.collection("payouts").doc(payoutId).get().then((value) => {});
  }

  static updatePreference(bool status) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool("loggedIn", status);
  }

  static logout() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool("loggedIn", false);
    await FirebaseAuth.instance.signOut().then((value) {
      Get.offAll(() => Login());
    });
  }
}
