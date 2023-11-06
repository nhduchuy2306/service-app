import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:service_app/models/register_model.dart';
import 'package:service_app/screens/login_screen.dart';
import 'package:service_app/services/account_service.dart';

import '../../widgets/google_login_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // Handle tap on screen to dismiss keyboard
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          controller: ScrollController(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 0),
                child: Center(
                  child: Image(
                    image: const AssetImage('assets/logo2.png'),
                    fit: BoxFit.fitWidth,
                    width: MediaQuery.of(context).size.width * 0.9,
                    // height: 250,
                    height: 150,
                  ),
                ),
              ),
              // const Text(
              //   'WELCOME TO ANT CHORES',
              //   style: TextStyle(
              //     fontSize: 24,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              // const SizedBox(height: 20),
              const Center(
                child: Text(
                  'SIGN UP',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    TextField(
                      controller: _phoneNumber,
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
                      controller: _password,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _name,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _address,
                      keyboardType: TextInputType.streetAddress,
                      decoration: const InputDecoration(
                        labelText: 'Address',
                      ),
                    ),
                    const SizedBox(height: 20),
                    ConstrainedBox(
                      constraints:
                          const BoxConstraints.tightFor(width: double.infinity),
                      child: ElevatedButton(
                        onPressed: () async {
                          RegisterModel registerModel = RegisterModel(
                              phoneNumber: _phoneNumber.text,
                              password: _password.text,
                              email: _email.text,
                              name: _name.text,
                              address: _address.text,
                              status: true);

                          bool success =
                              await AccountService.register(registerModel);

                          if (!success) {
                            Future.delayed(
                              const Duration(seconds: 3),
                              () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Register failed'),
                                  ),
                                );
                              },
                            );
                          } else {
                            Future.delayed(
                              const Duration(seconds: 3),
                              () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Register successfully! Please login'),
                                  ),
                                );
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                  (route) => false,
                                );
                              },
                            );
                          }
                        },
                        child: const Text('Sign Up'),
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
                        const Text("Already had an account? "),
                        TextButton(
                          onPressed: () {
                            // Handle login button click
                            Future.delayed(
                              const Duration(seconds: 3),
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
                          child: const Text('Login'),
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
