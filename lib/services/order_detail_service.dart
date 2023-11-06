import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:service_app/models/order_detail_model.dart';
import 'package:service_app/utils/constant.dart';

class OrderDetailService {
  static Future<List<OrderDetail>?> getOrderDetailByOrderId(int orderId) async {
    String url = "${Constant.baseUrlProduct}/p/orders/$orderId/orderdetails";
    List<OrderDetail> orderDetails = [];
    print(url);

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200 || response.statusCode == 201) {
      var orderDetailsJson = json.decode(utf8.decode(response.bodyBytes));
      for (var orderDetailJson in orderDetailsJson) {
        orderDetails.add(OrderDetail.fromJson(orderDetailJson));
      }
      return orderDetails;
    } else {
      return null;
    }
  }
}
