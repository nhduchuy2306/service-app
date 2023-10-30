import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:service_app/models/account_token_model.dart';
import 'package:service_app/models/customer.dart';
import 'package:service_app/models/login_model.dart';
import 'package:service_app/screens/main_screen/dashboard_screen.dart';
import 'package:service_app/services/account_service.dart';
import 'package:service_app/services/customer_service.dart';
import 'package:service_app/widgets/google_login_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // Handle tap on screen to dismiss keyboard
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 60, bottom: 20),
                child: Center(
                  child: Text(
                    'Welcome to AntChores',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'LOGIN',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    TextField(
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Phone number',
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      obscureText: true,
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
                    ),
                    const SizedBox(height: 20),
                    ConstrainedBox(
                      constraints:
                          const BoxConstraints.tightFor(width: double.infinity),
                      child: ElevatedButton(
                        onPressed: () async {
                          LoginModel loginModel = LoginModel(
                            phoneNumber: _phoneNumberController.text,
                            password: _passwordController.text,
                          );

                          AccountToken accountToken =
                              await AccountService.login(loginModel);

                          if (accountToken.token == "") {
                            Future.delayed(
                              const Duration(seconds: 3),
                              () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Login failed'),
                                  ),
                                );
                              },
                            );
                          } else {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setBool('loggedIn', true);
                            prefs.setString('token', accountToken.token ?? "");

                            Customer? customer =
                                await CustomerService.getCustomerByAccountId(
                                    accountToken.account!.accountId ?? 0);

                            if (customer != null) {
                              String customerString =
                                  json.encode(customer.toJson());
                              prefs.setString('customer', customerString);
                            }

                            Future.delayed(
                              const Duration(seconds: 3),
                              () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const DashBoardScreen(),
                                  ),
                                  (route) => false,
                                );
                              },
                            );
                          }
                        },
                        child: Text('Login'),
                      ),
                    ),
                    const SizedBox(height: 10),
                    GoogleLoginButton(
                      onPressed: () {
                        // Handle login with Google button click
                      },
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account? "),
                        TextButton(
                          onPressed: () {
                            // Handle register button click
                          },
                          child: const Text('Register'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
