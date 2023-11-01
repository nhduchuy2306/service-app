import 'package:flutter/material.dart';
import 'package:service_app/models/category.dart';
import 'package:service_app/models/customer.dart';
import 'package:service_app/models/task_detail_model.dart';
import 'package:service_app/screens/job_posting_screen/service_screen.dart';
import 'package:service_app/services/customer_service.dart';
import 'package:service_app/services/task_detail_service.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key, required this.category});

  final Category category;

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  List<TaskDetail> taskDetails = [];
  late Future<List<TaskDetail>?> futureTaskDetails;

  @override
  void initState() {
    super.initState();
    futureTaskDetails =
        TaskDetailService.getAllTaskDetailByCategoryId(widget.category.id!);

    futureTaskDetails.then((value) {
      setState(() {
        taskDetails = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Address"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          controller: ScrollController(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ServiceScreen(
                              taskDetails: taskDetails,
                              category: widget.category,
                            )),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  // this is show address of user
                  child: FutureBuilder<Customer>(
                    future: CustomerService.getCustomerFromSharedPreferences(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Card(
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
                                    Icons.location_on,
                                    size: 40,
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Center(
                                    child: Text(
                                      snapshot.data!.address ?? "",
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: ElevatedButton(
          onPressed: () {
            print("next");
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            backgroundColor: Colors.deepPurple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            'Add new Address',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
