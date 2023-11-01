import 'package:flutter/material.dart';
import 'package:service_app/models/category.dart';
import 'package:service_app/models/quantity_unit.dart';
import 'package:service_app/models/task_detail_model.dart';
import 'package:service_app/screens/job_posting_screen/quantity_time_screen.dart';

class ServiceScreen extends StatefulWidget {
  ServiceScreen({super.key, this.taskDetails, this.category});

  List<TaskDetail>? taskDetails = [];
  Category? category;

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(widget.category?.name ?? "Service"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: widget.taskDetails?.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: Card(
              color: Colors.white,
              surfaceTintColor: Colors.white,
              borderOnForeground: false,
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuantityTimeScreen(
                        type: widget.taskDetails?[index].unit! ==
                                QuantityEnum.Unit.index
                            ? QuantityEnum.Unit
                            : QuantityEnum.M2,
                      ),
                    ),
                  );
                },
                title: Text(
                  widget.taskDetails?[index].name ?? "",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.taskDetails?[index].description ?? "",
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    widget.taskDetails?[index].unit! == QuantityEnum.Unit.index
                        ? Text(
                            "${widget.taskDetails?[index].price?.toStringAsFixed(0)} VNĐ / piece",
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          )
                        : Text(
                            "${widget.taskDetails?[index].price?.toStringAsFixed(0)} VNĐ / m2",
                            style: const TextStyle(
                              color: Colors.black,
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
  }
}
