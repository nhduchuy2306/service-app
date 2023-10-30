import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:service_app/models/customer.dart';
import 'package:service_app/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerService {
  static Future<Customer?> getCustomerByAccountId(int accountId) async {
    String url = "${Constant.baseUrlAuth}/a/accounts/$accountId/customer";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(utf8.decode(response.bodyBytes));
      Customer customer = Customer.fromJson(data);
      return customer;
    } else {
      return null;
    }
  }

  static Future<Customer> getCustomerFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String customerString = prefs.getString('customer') ?? "";
    Customer customer = Customer.fromJson(json.decode(customerString));
    return customer;
  }
}
