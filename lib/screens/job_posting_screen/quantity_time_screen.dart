import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:page_transition/page_transition.dart';
import 'package:service_app/models/cart_model.dart';
import 'package:service_app/models/customer.dart';
import 'package:service_app/models/task_detail_model.dart';
import 'package:service_app/screens/job_posting_screen/confirm_checkout_screen.dart';

class QuantityTimeScreen extends StatefulWidget {
  const QuantityTimeScreen({
    super.key,
    required this.cartItems,
    required this.customer,
    required this.taskDetails,
  });

  final List<CartItems>? cartItems;
  final List<TaskDetail>? taskDetails;
  final Customer? customer;

  @override
  State<QuantityTimeScreen> createState() => _QuantityTimeScreenState();
}

class _QuantityTimeScreenState extends State<QuantityTimeScreen> {
  DateTime _selectedValue = DateTime.now();
  String hour = "00";
  String minute = "00";
  String quantity = "0";
  String area = "0";

  @override
  void initState() {
    super.initState();
    hour = "00";
    minute = "00";
    quantity = "0";
    area = "0";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quantity & Time"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        controller: ScrollController(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "Work Day",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            DatePicker(
              DateTime.now(),
              initialSelectedDate: DateTime.now(),
              selectionColor: Colors.black,
              selectedTextColor: Colors.grey,
              height: 100,
              daysCount: 7,
              onDateChange: (date) {
                setState(() {
                  _selectedValue = date;
                  print("date $_selectedValue");
                });
              },
            ),
            const SizedBox(height: 20),
            // show time picker
            const Text(
              "Work Time",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                DatePickerBdaya.showTimePicker(
                  context,
                  showTitleActions: true,
                  onChanged: (date) {
                    debugPrint(
                      'change $date in time zone ${date.timeZoneOffset.inHours}',
                    );
                  },
                  onConfirm: (date) {
                    String selectedHour = date.hour.toString().padLeft(2, '0');
                    String selectedMinute =
                        date.minute.toString().padLeft(2, '0');
                    setState(() {
                      hour = selectedHour;
                      minute = selectedMinute;
                    });

                    print("hour $hour");
                    print("minute $minute");
                  },
                );
              },
              child: Card(
                elevation: 0.5,
                color: Colors.white,
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.access_time,
                          size: 40,
                          color: Colors.black,
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Center(
                          child: Text(
                            "$hour:$minute",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 75,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: ElevatedButton(
          onPressed: () {
            CartModel? cartModel = CartModel(
              customerId: widget.customer?.id,
              workingAt: _selectedValue.toString(),
              startTime: DateTime(
                _selectedValue.year,
                _selectedValue.month,
                _selectedValue.day,
                int.parse(hour),
                int.parse(minute),
                int.parse("00"),
              ).toString(),
              cartItems: widget.cartItems,
            );

            Navigator.push(
              context,
              PageTransition(
                child: ConfirmCheckOutScreen(
                  cartModel: cartModel,
                  customer: widget.customer,
                  taskDetails: widget.taskDetails,
                ),
                type: PageTransitionType.rightToLeft,
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            "Next",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
