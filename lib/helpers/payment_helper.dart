import 'dart:convert';

import 'package:bid_parlour/controllers/account_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'database_helper.dart';

class PaymentHelper {
  static Future<Map<String, dynamic>> makePayment(
      {int target, int amount, int total, String id, String userId}) async {
    Map<String, dynamic> dataBody = {};
    AccountController _accountController = Get.find<AccountController>();
    final response = await http.post(
        Uri.parse('https://sandbox.intasend.com/api/v1/payment/collection/'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(<String, dynamic>{
          "public_key": "ISPubKey_test_bb04e9a5-a200-4c53-a0fa-da5a6e066b3e",
          "currency": "KES",
          "method": "M-PESA",
          "amount": amount,
          "api_ref": id,
          "name": _accountController.userName.value,
          "phone_number": _accountController.phone.value,
          "email": _accountController.email.value
        }));
    if (response.statusCode == 200) {
      Map<String, dynamic> decodedRes = jsonDecode(response.body);
      await DbHelper.makeBid(
          target: target,
          total: total,
          id: id,
          userId: userId,
          amount: amount,
          invoiceId: decodedRes['invoice']['invoice_id']);
      print(response.body);
      return {
        "invoice_id": decodedRes['invoice']['invoice_id'],
        "successful": true
      };
    } else {
      print(response.body);
      return {"invoice_id": "", "successful": false};
    }
  }

  static Future<bool> invoiceStatus(String invoiceId) async {
    final response = await http.post(
        Uri.parse('https://sandbox.intasend.com/api/v1/payment/status/'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(<String, dynamic>{
          "public_key": "ISPubKey_test_bb04e9a5-a200-4c53-a0fa-da5a6e066b3e",
          "invoice_id": invoiceId
        }));
    if (response.statusCode == 200) {
      print(response.body);
      Map<String, dynamic> decodedRes = jsonDecode(response.body);
      if (decodedRes['invoice']['state'] == "COMPLETE") {
        return true;
      } else {
        return false;
      }
    } else {
      print(response.body);
      return false;
    }
  }
}
