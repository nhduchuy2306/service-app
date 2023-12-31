import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:service_app/models/customer.dart';
import 'package:service_app/models/order_model.dart';
import 'package:service_app/screens/action_screen/action_detail_screen.dart';
import 'package:service_app/services/customer_service.dart';

class ActionScreen extends StatefulWidget {
  const ActionScreen({super.key});

  @override
  State<ActionScreen> createState() => _ActionScreenState();
}

class _ActionScreenState extends State<ActionScreen> {
  late Future<List<Order>> futureOrders =
      CustomerService.getOrderByStateOfCustomer(1, 1);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Action Screen'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Pending'),
              Tab(text: 'Accept'),
              Tab(text: 'Complete'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            // Pending Tab Content
            PendingTab(),
            // Accept Tab Content
            AcceptTab(),
            // Complete Tab Content
            CompleteTab(),
          ],
        ),
      ),
    );
  }
}

class PendingTab extends StatelessWidget {
  const PendingTab({super.key});

  @override
  Widget build(BuildContext context) {
    Future<List<Order>> fetchOrders() async {
      Customer customer =
          await CustomerService.getCustomerFromSharedPreferences();
      List<Order> orders =
          await CustomerService.getOrderByStateOfCustomer(customer.id ?? 1, 0);
      return orders;
    }

    // Replace this with your accepted jobs or customer list widget.
    return FutureBuilder<List<Order>>(
      future: fetchOrders(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.bottomToTop,
                      duration: const Duration(milliseconds: 500),
                      child: ActionDetailScreen(
                        order: snapshot.data![index],
                      ),
                    ),
                  );
                },
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: Card(
                        color: Colors.white,
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                snapshot.data?[index].categoryName ?? "",
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
                                    snapshot.data?[index].address ?? "",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data?[index].workingAt?.substring(
                                            0,
                                            snapshot.data?[index].startTime!
                                                .indexOf("T")) ??
                                        "",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data?[index].startTime?.substring(
                                          (snapshot.data?[index].startTime!
                                                      .indexOf("T") ??
                                                  1) +
                                              1,
                                          (snapshot.data?[index].startTime!
                                                  .length)! -
                                              3,
                                        ) ??
                                        "",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              height: 1,
                              color: Colors.grey,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${snapshot.data?[index].total?.toStringAsFixed(0)} VNĐ",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Positioned(
                      right: 20,
                      top: 20,
                      child: Icon(
                        Icons.pending_actions,
                        color: Colors.orange,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

class AcceptTab extends StatelessWidget {
  const AcceptTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Firstly, get customerId from SharePreferences
    Future<List<Order>> fetchOrders() async {
      Customer customer =
          await CustomerService.getCustomerFromSharedPreferences();
      List<Order> orders =
          await CustomerService.getOrderByStateOfCustomer(customer.id ?? 1, 1);
      return orders;
    }

    // Then, call CustomerService.getOrderByStateOfCustomer(customerId, 1)
    return FutureBuilder<List<Order>>(
      future: fetchOrders(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.bottomToTop,
                      duration: const Duration(milliseconds: 500),
                      child: ActionDetailScreen(
                        order: snapshot.data![index],
                      ),
                    ),
                  );
                },
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: Card(
                        color: Colors.white,
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                snapshot.data?[index].categoryName ?? "",
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
                                    snapshot.data?[index].address ?? "",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data?[index].workingAt?.substring(
                                            0,
                                            snapshot.data?[index].startTime!
                                                .indexOf("T")) ??
                                        "",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data?[index].startTime?.substring(
                                          (snapshot.data?[index].startTime!
                                                      .indexOf("T") ??
                                                  1) +
                                              1,
                                          (snapshot.data?[index].startTime!
                                                  .length)! -
                                              3,
                                        ) ??
                                        "",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              height: 1,
                              color: Colors.grey,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${snapshot.data?[index].total?.toStringAsFixed(0)} VNĐ",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Positioned(
                      right: 20,
                      top: 20,
                      child: Icon(
                        Icons.work,
                        color: Colors.brown,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const CircularProgressIndicator();
        }
        return const CircularProgressIndicator();
      },
    );
  }
}

class CompleteTab extends StatelessWidget {
  const CompleteTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Firstly, get customerId from SharePreferences
    Future<List<Order>> fetchOrders() async {
      Customer customer =
          await CustomerService.getCustomerFromSharedPreferences();
      List<Order> orders =
          await CustomerService.getOrderByStateOfCustomer(customer.id ?? 1, 2);
      return orders;
    }

    // Then, call CustomerService.getOrderByStateOfCustomer(customerId, 1)
    return FutureBuilder<List<Order>>(
      future: fetchOrders(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.bottomToTop,
                      duration: const Duration(milliseconds: 500),
                      child: ActionDetailScreen(
                        order: snapshot.data![index],
                      ),
                    ),
                  );
                },
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: Card(
                        color: Colors.white,
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                snapshot.data?[index].categoryName ?? "",
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
                                    snapshot.data?[index].address ?? "",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data?[index].workingAt?.substring(
                                            0,
                                            snapshot.data?[index].startTime!
                                                .indexOf("T")) ??
                                        "",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data?[index].startTime?.substring(
                                          (snapshot.data?[index].startTime!
                                                      .indexOf("T") ??
                                                  1) +
                                              1,
                                          (snapshot.data?[index].startTime!
                                                  .length)! -
                                              3,
                                        ) ??
                                        "",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              height: 1,
                              color: Colors.grey,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${snapshot.data?[index].total?.toStringAsFixed(0)} VNĐ",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Positioned(
                      right: 20,
                      top: 20,
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
