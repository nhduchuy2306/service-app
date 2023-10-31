import 'package:flutter/material.dart';
import 'package:service_app/models/customer.dart';
import 'package:service_app/services/customer_service.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key, required this.categoryId});

  final int categoryId;

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Address'),
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
              Container(
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
                                      fontSize: 16,
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
          child: const Text('Next'),
        ),
      ),
    );
  }
}
