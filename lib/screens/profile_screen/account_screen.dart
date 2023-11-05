import 'package:flutter/material.dart';
import 'package:service_app/models/customer.dart';
import 'package:service_app/screens/login_screen.dart';
import 'package:service_app/screens/profile_screen/history_screen.dart';
import 'package:service_app/services/customer_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'help_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        controller: ScrollController(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _header(),
            const SizedBox(height: 20),
            _body(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 5,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(
            flex: 1,
            child: CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage("assets/profile.png"),
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FutureBuilder<Customer>(
                  future: CustomerService.getCustomerFromSharedPreferences(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        "Welcome ${snapshot.data!.name ?? ""}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return Column(
      children: [
        _settingTag(
          Icons.person,
          "Personal Information",
          "Update your personal information",
          () {},
        ),
        _settingTag(
          Icons.bookmark,
          "Orders",
          "View your orders",
          () {},
        ),
        _settingTag(
          Icons.history_sharp,
          "History",
          "View your history",
          () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const HistoryScreen();
            }));
          },
        ),
        _settingTag(
          Icons.settings,
          "Settings",
          "Notification, Language, ...",
          () {},
        ),
        _settingTag(
          Icons.help,
          "Help",
          "Help and support",
          () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const HelpScreen();
            }));
          },
        ),
        _settingTag(
          Icons.logout,
          "Logout",
          "Logout from your account",
          () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.remove('loggedIn');
            prefs.remove('token');
            prefs.remove('customer');

            Future.delayed(
              const Duration(seconds: 0),
              () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                  (route) => false,
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _settingTag(
    IconData icon,
    String title,
    String subtitle,
    Function()? onTap,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 5,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 5,
      ),
      child: Card(
        color: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: ListTile(
          leading: Icon(icon),
          title: Text(title),
          subtitle: Text(subtitle),
          onTap: onTap,
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
