import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:service_app/models/cart_model.dart';
import 'package:service_app/models/customer.dart';
import 'package:service_app/models/quantity_unit.dart';
import 'package:service_app/models/task_detail_model.dart';
import 'package:service_app/screens/main_screen/dashboard_screen.dart';
import 'package:service_app/services/order_service.dart';

class ConfirmCheckOutScreen extends StatefulWidget {
  const ConfirmCheckOutScreen({
    super.key,
    required this.cartModel,
    required this.customer,
    required this.taskDetails,
  });

  final CartModel? cartModel;
  final Customer? customer;
  final List<TaskDetail>? taskDetails;

  @override
  State<ConfirmCheckOutScreen> createState() => _ConfirmCheckOutScreenState();
}

class _ConfirmCheckOutScreenState extends State<ConfirmCheckOutScreen> {
  @override
  Widget build(BuildContext context) {
    String workingAtTime = widget.cartModel!.workingAt ?? "";
    DateTime workingAtTimeDate = DateTime.parse(workingAtTime);
    String formattedWorkingAtTime =
        "${workingAtTimeDate.year}-${workingAtTimeDate.month.toString().padLeft(2, '0')}-${workingAtTimeDate.day.toString().padLeft(2, '0')}";

    String startTime = widget.cartModel!.startTime ?? "";
    DateTime startTimeDate = DateTime.parse(startTime);
    String formattedTime =
        "${startTimeDate.hour.toString().padLeft(2, '0')}:${startTimeDate.minute.toString().padLeft(2, '0')}";

    double getTotalPrice() {
      double totalPrice = 0;
      for (int i = 0; i < widget.cartModel!.cartItems!.length; i++) {
        CartItems cartItem = widget.cartModel!.cartItems![i];
        if (cartItem.unit == QuantityEnum.M2.index) {
          totalPrice += cartItem.price ?? 0;
        } else {
          totalPrice += (cartItem.price ?? 1) * (cartItem.quantity ?? 1);
        }
      }
      return totalPrice;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirm Check Out"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        controller: ScrollController(),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Address: ",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  widget.customer!.address ?? "",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Service Date:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  formattedWorkingAtTime,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Text(
                "Service Time:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  formattedTime,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Total:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "${getTotalPrice().toStringAsFixed(0)} VNĐ",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "List Posting Service:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.taskDetails!.length,
                itemBuilder: (context, index) {
                  TaskDetail taskDetail = widget.taskDetails![index];
                  return Card(
                    color: Colors.white,
                    surfaceTintColor: Colors.white,
                    borderOnForeground: false,
                    child: ListTile(
                      title: Text(
                        taskDetail.name ?? "",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            taskDetail.description ?? "",
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "${taskDetail.price?.toStringAsFixed(0)} VNĐ",
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          taskDetail.unit == QuantityEnum.Unit.index
                              ? Text(
                                  "Quantity: ${widget.cartModel!.cartItems![index].quantity}",
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 75,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: ElevatedButton(
          onPressed: () async {
            String response = await OrderService.createOrder(
              widget.cartModel ?? CartModel(),
            );

            if (response == "Success") {
              Future.delayed(
                const Duration(milliseconds: 500),
                () {
                  Navigator.push(
                    context,
                    PageTransition(
                      child: const DashBoardScreen(),
                      type: PageTransitionType.fade,
                    ),
                  );
                },
              );
            } else {
              Future.delayed(
                const Duration(milliseconds: 500),
                () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Create order failed"),
                    ),
                  );
                },
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            "Check Out",
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
