import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:service_app/services/customer_service.dart';
import 'package:service_app/services/task_detail_service.dart';


void main() {
  testWidgets('Call API', (WidgetTester tester) async {
    CustomerService.getOrderByStateOfCustomer(1, 1);
  });
}