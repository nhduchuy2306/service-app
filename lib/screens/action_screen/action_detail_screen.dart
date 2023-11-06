import 'package:flutter/material.dart';
import 'package:service_app/models/order_detail_model.dart';
import 'package:service_app/models/order_model.dart';
import 'package:service_app/services/order_detail_service.dart';

class ActionDetailScreen extends StatefulWidget {
  const ActionDetailScreen({super.key, required this.order});

  final Order order;

  @override
  State<ActionDetailScreen> createState() => _ActionDetailScreenState();
}

class _ActionDetailScreenState extends State<ActionDetailScreen> {
  List<OrderDetail> orderDetails = [];
  Future<List<OrderDetail>?>? orderDetailFuture;

  @override
  void initState() {
    super.initState();
    orderDetailFuture =
        OrderDetailService.getOrderDetailByOrderId(widget.order.id!);

    orderDetailFuture!.then((value) {
      setState(() {
        orderDetails = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<OrderDetail>?>(
      future: orderDetailFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: const Text("Action Detail"),
              centerTitle: true,
            ),
            body: ListView.builder(
              itemCount: orderDetails.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  child: Card(
                    child: ListTile(
                      title: Text(
                        "Task: ${orderDetails[index].taskDetailName!}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Time: ${widget.order.startTime?.substring(
                              (widget.order.startTime!.indexOf("T")) + 1,
                              (widget.order.startTime!.length) - 3,
                            )}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Quantity: ${orderDetails[index].quantity.toString()}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
