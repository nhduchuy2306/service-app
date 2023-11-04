import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:service_app/models/cart_model.dart';
import 'package:service_app/utils/constant.dart';

class OrderService {
  static Future<String> createOrder(CartModel cartModel) async {
    String workingAtString = cartModel.workingAt ?? "";
    DateTime workingAtDateTime = DateTime.parse(workingAtString);
    String workingAtTimeString =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(workingAtDateTime);

    String startTimeString = cartModel.startTime ?? "";
    DateTime startTimeDateTime = DateTime.parse(startTimeString);
    String startTimeTimeString =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(startTimeDateTime);

    cartModel.workingAt = workingAtTimeString;
    cartModel.startTime = startTimeTimeString;

    String url = "${Constant.baseUrlProduct}/p/orders";
    print(url);

    final res = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(cartModel.toJson()),
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      return "Success";
    } else {
      return "Failed";
    }
  }
}
