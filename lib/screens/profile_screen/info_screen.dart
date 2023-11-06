import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:service_app/models/customer.dart';
import 'package:service_app/services/customer_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  Customer? customer;
  late Future<Customer> futureCustomer;
  late Future<String> phonePref;
  String? phone;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureCustomer = CustomerService.getCustomerFromSharedPreferences();
    phonePref = getPhoneNumber();

    phonePref.then((value) => {
      setState(() {
        phone = value;
      })
    });

    futureCustomer.then((value) {
      setState(() {
        customer = value;
      });
    });
  }

  Future<String> getPhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String phone = prefs.getString('phone') ?? "";
    return phone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Information'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/profile.png'),
                radius: 40,
              ),
            ),
            Divider(
              height: 60,
              color: Colors.grey[800],
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.person,
                  color: Colors.grey[400],
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Name",
                  style: TextStyle(
                      color: Colors.grey[400], fontSize: 18, letterSpacing: 1),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              customer?.name ?? "No name",
              style: TextStyle(
                  color: Colors.amberAccent[200],
                  letterSpacing: 2,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Row(
              children: <Widget>[
                Icon(
                  Icons.home,
                  color: Colors.grey[400],
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Address",
                  style: TextStyle(
                      color: Colors.grey[400], fontSize: 18, letterSpacing: 1),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              customer?.address ?? "No address",
              style: TextStyle(
                  color: Colors.amberAccent[200],
                  letterSpacing: 2,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Row(
              children: <Widget>[
                Icon(
                  Icons.phone,
                  color: Colors.grey[400],
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  phone ?? "No phone",
                  style: TextStyle(
                      color: Colors.grey[400], fontSize: 18, letterSpacing: 1, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: <Widget>[
                Icon(
                  Icons.email,
                  color: Colors.grey[400],
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  customer?.email ?? "No email",
                  style: TextStyle(
                      color: Colors.grey[400], fontSize: 18, letterSpacing: 1, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
