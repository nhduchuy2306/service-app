import 'package:flutter/material.dart';

class Page1Screen extends StatelessWidget {
  const Page1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: const AssetImage('assets/cleaning-cart.png'),
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width * 0.7,
          ),
          const SizedBox(height: 20),
          const Text(
            "This is the first page of the onboarding screen.",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
